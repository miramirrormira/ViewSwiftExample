//
//  Networking.swift
//  ViewSwiftlyExample
//
//  Created by Mira Yang on 5/21/24.
//

import Foundation
import NetSwiftly
import ViewSwiftly

let networkingConfig = NetworkConfiguration(host: "api.themoviedb.org", scheme: "https", apiBaseRoute: "3")
let popularMoviesEndpoint = Endpoint(path: "movie/popular", method: .get, queryParameters: ["language" : "en-US", "api_key": "f62ad260479b5c73439955416bb7eb4e"])

let transformMoviePage: (MoviePage) -> [Movie] = { moviePage in
    moviePage.results.map { movie in
        Movie(title: movie.title, page: moviePage.page)
    }
}

let popularMoviesViewModel: PaginatedItemsViewModel<Movie, MoviePage> = .init(networkConfiguration: networkingConfig, endpoint: popularMoviesEndpoint, paginationQueryStrategy: PageBasedQueryStrategy(pageKey: "page"), transform: transformMoviePage)
