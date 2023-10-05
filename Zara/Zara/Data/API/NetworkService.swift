//
//  NetworkService.swift
//  Zara
//
//  Created by Eduard Quintanilla Alcaide on 3/10/23.
//

import Foundation

// A struct to define API endpoints
struct APIEndpoint {
    // Define the URL for the character list endpoint
    static let characterList = "https://rickandmortyapi.com/api/character"
}

// Enum to define HTTP methods
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    // Add more methods if necessary
}

// Protocol that declares the request function
protocol NetworkServiceProtocol {
    func request<T: Decodable>(url: URL, method: HTTPMethod, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

// A struct for handling network requests and response caching
struct NetworkService: NetworkServiceProtocol {
    // Create an instance of NSCache to store cached responses
    private let responseCache = NSCache<NSString, CachedData>()
    
    // Perform a network request to retrieve data of a specified type
    func request<T: Decodable>(url: URL, method: HTTPMethod, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let cacheKey = url.absoluteString as NSString
        
        // Check if the response is cached
        if let cachedResponseData = responseCache.object(forKey: cacheKey) {
            do {
                // Decode and return the cached response
                let decodedResponse = try JSONDecoder().decode(responseType, from: cachedResponseData.data)
                completion(.success(decodedResponse))
                return
            } catch {
                // If decoding the cached response fails, continue with the network request
            }
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                // Handle and report network request errors
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                // Report an error when no data is received
                completion(.failure(AppError.noData))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                // Report an error for an invalid HTTP response
                completion(.failure(AppError.invalidResponse))
                return
            }
            
            if (200..<300).contains(httpResponse.statusCode) {
                // Cache the response before decoding
                let cachedData = CachedData(data)
                self.responseCache.setObject(cachedData, forKey: cacheKey)
                
                do {
                    // Decode and return the network response
                    let decodedResponse = try JSONDecoder().decode(responseType, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    // Handle and report any decoding errors
                    completion(.failure(error))
                }
            } else {
                // Report an HTTP error
                completion(.failure(AppError.httpError(httpResponse.statusCode)))
            }
        }.resume()
    }
}

// Enum to represent network-related errors
enum AppError: Error, Equatable {
    case noData
    case invalidURL
    case invalidResponse
    case httpError(Int)
}
