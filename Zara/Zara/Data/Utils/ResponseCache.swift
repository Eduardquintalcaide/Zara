//
//  ResponseCache.swift
//  Zara
//
//  Created by Eduard Quintanilla Alcaide on 3/10/23.
//

import Foundation

// A class for wrapping and caching Data objects
class CachedData: NSObject {
    let data: Data
    
    // Initialize with the provided Data object
    init(_ data: Data) {
        self.data = data
    }
}

// A class for managing a response cache using NSCache
class ResponseCache {
    // Singleton instance
    static let shared = ResponseCache()
    
    // NSCache for storing cached data
    private let cache = NSCache<NSString, CachedData>()
    
    // Private initializer to enforce singleton pattern
    private init() { }
    
    // Retrieve cached data for a given key
    func cachedResponse(for key: String) -> Data? {
        if let cachedData = cache.object(forKey: key as NSString) {
            return cachedData.data
        }
        return nil
    }
    
    // Cache the provided data for a specific key
    func cacheResponse(_ data: Data, for key: String) {
        let cachedData = CachedData(data)
        cache.setObject(cachedData, forKey: key as NSString)
    }
}

