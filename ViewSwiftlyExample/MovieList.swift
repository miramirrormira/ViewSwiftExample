//
//  MovieList.swift
//  ViewSwiftlyExample
//
//  Created by Mira Yang on 8/10/24.
//

import Foundation
import SwiftUI
import ViewSwiftly

struct MovieList: View {
    
    @StateObject var vm: AnyViewModel<PaginatedItemsState<Movie>, PaginatedItemsActions<Movie>>
    
    init() {
        self._vm = StateObject(wrappedValue: .init(popularMoviesViewModel))
    }
    
    var body: some View {
        PaginatedList(viewModel: vm) { movie in
            MovieRow(movie: movie)
        }
        .onAppear(perform: {
            Task {
                await vm.trigger(.requestNextPage)
            }
        })
    }
}
