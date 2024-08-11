//
//  UpdateFireabseQueryRefreshStrategy.swift
//  anony
//
//  Created by Mira Yang on 6/6/24.
//  Copyright © 2024 Snaap. All rights reserved.
//

import Foundation
import ViewSwiftly
import NetSwiftly
import Firebase

class UpdateFireabseQueryRefreshStrategy<T: Decodable & Identifiable & InitializableFromDictionary, S: Identifiable>: RefreshStrategy {
    
    typealias ItemStateType = S
    typealias ItemType = T
    var query: Query
    
    init(query: Query) {
        self.query = query
    }
    
    @MainActor
    func refresh(vm: ViewSwiftly.PaginatedItemsViewModel<T, S>) {
        let requestable = FirebasePaginatedQueryCommand<T>(query: query)
        vm.requestable = AnyRequestable(requestable)
        vm.state.items = []
        Task {
            await vm.trigger(.requestNextPage)
        }
    }
    
}
