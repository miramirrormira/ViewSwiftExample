//
//  AddMoviesAndRemoveOldOnes.swift
//  ViewSwiftlyExample
//
//  Created by Mira Yang on 5/22/24.
//

import Foundation
import ViewSwiftly

class AddMoviesAndRemoveOldOnes: MergeItemsStrategy {
    
    @MainActor
    func merge<Movie>(vm: ViewSwiftly.PaginatedItemsViewModel<Movie>, with newItems: [Movie]) async {
        vm.state.items.append(contentsOf: newItems)
        if vm.state.items.count > 50 {
            print("💜 removing the first 10 movies")
            vm.state.items.removeFirst(10)
        }
    }
}
