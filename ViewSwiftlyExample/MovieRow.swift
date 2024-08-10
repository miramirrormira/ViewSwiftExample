//
//  MovieRow.swift
//  ViewSwiftlyExample
//
//  Created by Mira Yang on 8/10/24.
//

import Foundation
import SwiftUI

struct MovieRow: View {
    @State var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    var body: some View {
        Text(movie.title)
    }
}

