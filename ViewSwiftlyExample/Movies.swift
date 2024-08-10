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

struct MoviePage: Decodable, Identifiable {
    var id: Int {
        page
    }
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


