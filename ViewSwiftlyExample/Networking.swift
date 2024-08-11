//
//  Networking.swift
//  ViewSwiftlyExample
//
//  Created by Mira Yang on 5/21/24.
//

import Foundation
import NetSwiftly
import ViewSwiftly

// MARK: Movie List
let networkingConfig = NetworkConfiguration(host: "api.themoviedb.org", scheme: "https", apiBaseRoute: "3")
let popularMoviesEndpoint = Endpoint(path: "movie/popular", method: .get, queryParameters: ["language" : "en-US", "api_key": "f62ad260479b5c73439955416bb7eb4e"])


let transformMoviePage: (MoviePage) -> [Movie] = { moviePage in
    moviePage.results.map { movie in
        Movie(title: movie.title, page: moviePage.page, poster_path: movie.poster_path)
    }
}

let popularMoviesViewModel: PaginatedItemsViewModel<Movie, Movie> = .init(networkConfiguration: networkingConfig, 
                                                                          endpoint: popularMoviesEndpoint,
                                                                          paginationQueryStrategy: PageBasedQueryStrategy(pageKey: "page"),
//                                                                          fetchItemsStrategy: .init(FetchMoviePostersStrategy()),
                                                                          transform: transformMoviePage)

//let popularMoviesViewModelWithOldPageRemoved: PaginatedItemsViewModel<Movie, Movie> = .init(networkConfiguration: networkingConfig, endpoint: popularMoviesEndpoint, paginationQueryStrategy: PageBasedQueryStrategy(pageKey: "page"), mergeItemsStrategy: .init(AddMoviesAndRemoveOldOnes()), transform: transformMoviePage)


// MARK: Movie Posters Assets
let moviePosterConfig = NetworkConfiguration(host: "image.tmdb.org", scheme: "https", apiBaseRoute: "t/p/original")
