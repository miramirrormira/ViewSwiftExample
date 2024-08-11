//
//  Cache.swift
//  ViewSwiftlyExample
//
//  Created by Mira Yang on 8/10/24.
//

import Foundation
import CacheSwiftly
import SwiftUI

struct MoviePosterMemoryCacheKey: EnvironmentKey {
    static var defaultValue: AnyCachable<Task<Data, Error>> = AnyCachable(MemoryCache())
}

extension EnvironmentValues {
    var imagePosterMemoryCache: AnyCachable<Task<Data, Error>> {
        get { self[MoviePosterMemoryCacheKey.self] }
        set { self[MoviePosterMemoryCacheKey.self] = newValue }
    }
}

struct MoviePosterDiskCacheKey: EnvironmentKey {
    static var defaultValue: AnyCachable<Data> = {
        return try! AnyCachable(DiskCache(label: "moviePosters", costLimit: 50))
    }()
}

extension EnvironmentValues {
    var imagePosterDiskCache: AnyCachable<Data> {
        get { self[MoviePosterDiskCacheKey.self] }
        set { self[MoviePosterDiskCacheKey.self] = newValue }
    }
}
