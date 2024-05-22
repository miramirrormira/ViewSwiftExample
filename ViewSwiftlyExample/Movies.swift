//
//  Movies.swift
//  ViewSwiftlyExample
//
//  Created by Mira Yang on 5/16/24.
//

import Foundation
import SwiftUI
import ViewSwiftly
import NetSwiftly

struct Movies: View {
    
    @StateObject private var vm: AnyViewModel<PaginatedItemsState<Movie>, PaginatedItemsActions<Movie>>
    
    init() {
        self._vm = StateObject(wrappedValue: AnyViewModel(popularMoviesViewModel))
    }
    
    var body: some View {
        PaginatedList(viewModel: vm) { movie in
            HStack {
                Text(movie.title)
                Spacer()
                Text("\(movie.page ?? -1)")
            }
        } loadingView: {
            EmptyView()
        } emptyListView: {
            EmptyView()
        }
        .task {
            await vm.trigger(.requestNextPage)
        }
    }
}

struct MoviePage: Decodable {
    var page: Int
    var results: [Movie]
}

struct Movie: Decodable, Hashable, Identifiable {
    var title: String
    var page: Int?
    var id: String {
        return title + "\(String(describing: page))"
    }
}
