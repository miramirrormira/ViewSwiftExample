//
//  FirebaseErrors.swift
//  anony
//
//  Created by Mira Yang on 6/5/24.
//  Copyright © 2024 Snaap. All rights reserved.
//

import Foundation
public enum FirebaseErrors: Error {
    case cannotGetDataFromSnapshot
    case cannotInitializeObject
    case fileNotExist
}
