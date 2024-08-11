//
//  FirestoreGetFileCommand.swift
//  anony
//
//  Created by Mira Yang on 6/12/24.
//  Copyright © 2024 Snaap. All rights reserved.
//

import Foundation
import NetSwiftly
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreGetFileCommand: Requestable {
    
    typealias Response = Data
    let filePath: String
    let storage: Storage
    let maxSize: Int64
    
    init(storage: Storage = Storage.storage(),
         filePath: String,
         maxSize: Int64) {
        self.filePath = filePath
        self.storage = storage
        self.maxSize = maxSize
    }
    
    func request() async throws -> Data {
        let reference = storage.reference(withPath: filePath)
        return try await withCheckedThrowingContinuation { continuation in
            reference.getData(maxSize: maxSize) { data, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                if let data = data {
                    continuation.resume(returning: data)
                } else {
                    continuation.resume(throwing: FirebaseErrors.fileNotExist)
                }
            }
        }
    }
    
}
