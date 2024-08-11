//
//  MovieRow.swift
//  ViewSwiftlyExample
//
//  Created by Mira Yang on 8/10/24.
//

import Foundation
import SwiftUI
import ViewSwiftly

struct MovieRow: View {
    @State private var movie: Movie
    @State private var data: Data?
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var body: some View {
        VStack {
            Text(movie.title)
            Group {
                if let imageData = data, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                } else {
                    ProgressView()
                        .frame(width: 200, height: 200)
                        .background(Color.gray.opacity(0.2))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .task {
            guard self.data == nil else { return }
            do {
                self.data = try await FetchMoviePostersStrategy.downloadMoviePoster(movie)
            } catch {
                print("error: \(error)")
            }
        }
        .onDisappear(perform: {
            self.data = nil
        })
    }
}

