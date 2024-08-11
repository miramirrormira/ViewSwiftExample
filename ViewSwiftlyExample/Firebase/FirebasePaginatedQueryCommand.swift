//
//  FirebasePaginatedQueryCommand.swift
//  anony
//
//  Created by Mira Yang on 6/5/24.
//  Copyright © 2024 Snaap. All rights reserved.
//

import Foundation
import NetSwiftly
import ViewSwiftly
import Firebase
import FirebaseStorage

public class FirebasePaginatedQueryCommand<T: Decodable & InitializableFromDictionary>: Requestable {
    
    private var reachedLastPage: Bool = false
    private var lastSnapshot: DocumentSnapshot?
    var query: Query
    
    init(query: Query) {
        self.query = query
    }
    
    public func request() async throws -> [T] {
        guard !reachedLastPage else {
            Logger.debug("reached the last item snapshot, no more \(T.Type.self) to download")
            return []
        }
        var paginatedQuery = query
        if let lastSnapshot = self.lastSnapshotForPaginatedItems {
            paginatedQuery = paginatedQuery.start(afterDocument: lastSnapshot)
        }
        let documents = try await paginatedQuery.getDocuments().documents
        lastSnapshotForPaginatedItems = documents.last
        reachedLastItemSnapshot = lastSnapshotForPaginatedItems == nil
        return documents.compactMap { snapshot in
            var data = snapshot.data()
            data["id"] = snapshot.documentID
            return T.init(dictionary: data)
        }
    }
}

public extension PaginatedItemsViewModel {
    convenience init(query: Query,
                     mergeItemsStrategy: AnyMergeItemsStrategy<ItemType, ItemStateType> = .init(AppendItems()),
                     refreshStrategy: AnyRefreshStrategy<ItemType, ItemStateType>? = nil,
                     label: String = "",
                     fetchItemsStrategy: AnyFetchItemsStrategy<ItemType>? = nil) where ItemType: InitializableFromDictionary, ItemType == ItemStateType {
        let requestable = FirebasePaginatedQueryCommand<ItemType>(query: query)
        self.init(requestable: AnyRequestable(requestable),
                  mergeItemsStrategy: mergeItemsStrategy,
                  refreshStrategy: refreshStrategy,
                  fetchItemsStrategy: fetchItemsStrategy,
                  label: label)
    }
    
    convenience init(query: Query,
                     mergeItemsStrategy: AnyMergeItemsStrategy<ItemType, ItemStateType> = .init(AppendItems()),
                     refreshStrategy: AnyRefreshStrategy<ItemType, ItemStateType>? = nil,
                     label: String = "",
                     toItemState: @escaping (ItemType) async throws -> ItemStateType,
                     fetchItemsStrategy: AnyFetchItemsStrategy<ItemType>? = nil) where ItemType: InitializableFromDictionary {
        let requestable = FirebasePaginatedQueryCommand<ItemType>(query: query)
        self.init(requestable: AnyRequestable(requestable),
                  mergeItemsStrategy: mergeItemsStrategy,
                  refreshStrategy: refreshStrategy,
                  fetchItemsStrategy: fetchItemsStrategy,
                  label: label,
                  toItemState: toItemState)
    }
}
