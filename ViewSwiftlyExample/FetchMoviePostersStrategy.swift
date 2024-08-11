//
//  FetchMoviePostersStrategy.swift
//  ViewSwiftlyExample
//
//  Created by Mira Yang on 8/10/24.
//

import Foundation
import ViewSwiftly
import NetSwiftly

final class FetchMoviePostersStrategy: FetchItemsStrategy {
    
    typealias Item = Movie
    static let semaphore: AsyncSemaphore = .init(value: 5)
    
    func onFetchItems(_ items: [Movie]) async throws {
        for item in items {
            Task {
                try await FetchMoviePostersStrategy.downloadMoviePoster(item)
            }
        }
    }
    
    static func downloadMoviePoster(_ movie: Movie) async throws -> Data? {
        
        guard let poster_path = movie.poster_path else { return nil }
        
        let endpoint = Endpoint(path: poster_path, method: .get)
        
        var finalCommand: AnyRequestable<Data> = .init(URLRequestCommand<Data>(urlRequestDirector: EndpointURLRequestDirector(networkConfiguration: moviePosterConfig, endpoint: endpoint)))
        
        finalCommand = .init(CachedRequestableDecorator(cache: MoviePosterDiskCacheKey.defaultValue, key: movie.id, requestable: finalCommand))
        finalCommand = .init(CachedTaskRequestableDecorator(cache: MoviePosterMemoryCacheKey.defaultValue, key: movie.id, requestable: finalCommand))
        
        await FetchMoviePostersStrategy.semaphore.wait()
        defer {
            FetchMoviePostersStrategy.semaphore.signal()
        }
        return try await finalCommand.request()
    }
}
