//
//  FirebaseQueryCommand.swift
//  anony
//
//  Created by Mira Yang on 6/5/24.
//  Copyright © 2024 Snaap. All rights reserved.
//

import Foundation
import NetSwiftly
import Firebase
import FirebaseStorage

public class FirebaseQueryCommand<T: Decodable & InitializableFromDictionary>: Requestable {
    public typealias Response = [T]
    var query: Query
    init(query: Query) {
        self.query = query
    }
    public func request() async throws -> [T] {
        try await query.getDocuments().documents.compactMap { snapshot in
            var data = snapshot.data()
            data["id"] = snapshot.documentID
            return T.init(dictionary: data)
        }
    }
}
