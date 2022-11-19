//
//  NetworkService.swift
//  Shared
//
//  Created by Gustavo Araujo Santos on 14/11/22.
//

import Foundation

public enum NetworkError: Error {
    case badResponse
    case error(Error)
}

public enum HTTPMethodType: String {
    case get    = "GET"
    case post   = "POST"
}

public protocol NetworkServiceProtocol {
    func request(path: String, httpMethod: HTTPMethodType, body: [String: Any]?, headerAuthorization: String?) async throws -> Data
}

public class NetworkService: NetworkServiceProtocol {
    public init() {}

    public func request(path: String, httpMethod: HTTPMethodType, body: [String: Any]?, headerAuthorization: String?) async throws -> Data {
        // make url
        guard var urlComponents = URLComponents(string: "http://localhost:3001") else {
            fatalError("Url generation")
        }
        urlComponents.path = path

        guard let url = urlComponents.url else {
            fatalError("Url generation")
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = [
            "Accept": "application/json",
            "Content-Type":"application/json"
        ]

        if let token = headerAuthorization {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        if let body = body {
            // make body in JSON
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: body)
                urlRequest.httpBody = jsonData
            } catch {
                fatalError("JSON Serialization for body request")
            }
        }

        // urlSession
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            if let httpResponse = response as? HTTPURLResponse {
                guard httpResponse.statusCode == 200 else {
                    throw NetworkError.badResponse
                }
            }

            return data
        } catch {
            throw NetworkError.error(error)
        }
    }
}
