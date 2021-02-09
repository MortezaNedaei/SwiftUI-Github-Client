//
//  EnvironmentValues+ImageCache.swift
//  SwiftUI-Github-Client
//
//  Created by MoNe on 11/16/1399 AP.
//

import SwiftUI

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
