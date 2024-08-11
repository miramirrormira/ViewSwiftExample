//
//  FirestoreSendFileCommand.swift
//  anony
//
//  Created by Mira Yang on 6/21/24.
//  Copyright © 2024 Snaap. All rights reserved.
//

import Foundation
import NetSwiftly
import FirebaseFirestore
import FirebaseStorage

class FirestoreSendFileCommand: Requestable {
    typealias Response = Void
    
    let data: Data
    let filePath: String
    let contentType: String
    let storage: Storage
    
    init(_ data: Data, 
         filePath: String,
         contentType: String,
         storage: Storage) {
        self.data = data
        self.filePath = filePath
        self.contentType = contentType
        self.storage = storage
    }
    
    func request() async throws -> Void {
        let metadata = StorageMetadata()
        let reference = storage.reference(withPath: filePath)
        metadata.contentType = contentType
        let _ = try await reference.putDataAsync(data, metadata: metadata)
    }
}
