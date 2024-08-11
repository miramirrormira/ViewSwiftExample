//
//  FirebaseSetDocumentCommand.swift
//  anony
//
//  Created by Mira Yang on 6/21/24.
//  Copyright © 2024 Snaap. All rights reserved.
//

import Foundation
import NetSwiftly
import FirebaseFirestore

class FirebaseSetDocumentCommand<T: Encodable>: Requestable {
    
    typealias Response = String
    
    var data: [String: Any]
    let collectionReference: CollectionReference
    
    init(_ object: T, collectionReference: CollectionReference) throws {
        self.data = try object.toDictionary()
        self.collectionReference = collectionReference
    }
    
    func request() async throws -> String {
        let documentId = collectionReference.document().documentID
        try await collectionReference.document(documentId).setData(data)
        return documentId
    }
    
}
