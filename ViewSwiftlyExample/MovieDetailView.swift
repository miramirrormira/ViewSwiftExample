//
//  MovieDetailView.swift
//  ViewSwiftlyExample
//
//  Created by Mira Yang on 8/10/24.
//

import Foundation
import SwiftUI

struct MovieDetailView: View {
    @StateObject var vm: MovieDetailVM = .init()
    var body: some View {
        Text("🎈")
    }
}

class MovieDetailVM: ObservableObject {
    init() {
        print("init MovieDetailVM")
    }
    deinit {
        print("deinit MovieDetailVM")
    }
}
