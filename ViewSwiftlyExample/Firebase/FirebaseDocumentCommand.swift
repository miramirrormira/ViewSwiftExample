//
//  FirebaseDocumentCommand.swift
//  anony
//
//  Created by Mira Yang on 6/5/24.
//  Copyright © 2024 Snaap. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import NetSwiftly

public class FirebaseDocumentCommand<T: Decodable & InitializableFromDictionary>: Requestable {
    
    public typealias Response = T
    
    var documentReference: DocumentReference
    public init(documentReference: DocumentReference) {
        self.documentReference = documentReference
    }
    
    public func request() async throws -> T {
        let snapshot = try await documentReference.getDocument()
        guard var data = snapshot.data() else {
            throw FirebaseErrors.cannotGetDataFromSnapshot
        }
        data["id"] = snapshot.documentID
        guard let object = T.init(dictionary: data) else {
            throw FirebaseErrors.cannotInitializeObject
        }
        return object
    }
}
