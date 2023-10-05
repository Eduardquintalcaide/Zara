//
//  ImageLoader.swift
//  Zara
//
//  Created by Eduard Quintanilla Alcaide on 3/10/23.
//

import Foundation
import UIKit

// A class for loading and caching images from URLs
class ImageLoader {
    static let shared = ImageLoader()
    
    // Cache for storing loaded images
    private let imageCache = NSCache<NSString, UIImage>()
    
    // Private initializer to enforce singleton pattern
    private init() { }
    
    // Loads an image from a given URL and provides a callback with the image or nil
    func loadImage(fromURL urlString: String, completion: @escaping (UIImage?) -> Void) {
        // Check if the image is already in the cache
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            completion(cachedImage)
        } else {
            // If not in cache, create a URL from the provided string
            guard let imageURL = URL(string: urlString) else {
                completion(nil)
                return
            }
            
            var request = URLRequest(url: imageURL)
            
            // Use protocol cache policy for request
            request.cachePolicy = .useProtocolCachePolicy
            
            // Fetch the image data from the URL
            URLSession.shared.dataTask(with: request) { (data, _, error) in
                if let error = error {
                    // Handle and log any error during image loading
                    print("Error loading image: \(error)")
                    completion(nil)
                } else if let data = data, let image = UIImage(data: data) {
                    // Cache the loaded image and provide it in the callback
                    self.imageCache.setObject(image, forKey: urlString as NSString)
                    completion(image)
                } else {
                    // If no image data or an error occurred, provide nil in the callback
                    completion(nil)
                }
            }.resume()
        }
    }
}



