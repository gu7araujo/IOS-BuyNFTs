//
//  NetworkService.swift
//  Infrastructure
//
//  Created by Gustavo Araujo Santos on 10/08/22.
//

import Foundation

enum NetworkError: Error {
    case error(Error)
}

public enum HTTPMethodType: String {
    case get    = "GET"
    case post   = "POST"
}

public protocol NetworkServiceProtocol {
    func request(path: String, httpMethod: HTTPMethodType, body: [String: Any]?, headerAuthorization: String?) async -> Result<Data, Error>
}

public class NetworkService: NetworkServiceProtocol {
    public init() {}

    public func request(path: String, httpMethod: HTTPMethodType, body: [String: Any]?, headerAuthorization: String?) async -> Result<Data, Error> {
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
            let (data, _) = try await URLSession.shared.data(for: urlRequest)

            return .success(data)
        } catch {
            return .failure(NetworkError.error(error))
        }
    }
}
