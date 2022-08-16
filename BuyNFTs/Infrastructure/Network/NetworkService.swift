//
//  NetworkService.swift
//  Infrastructure
//
//  Created by Gustavo Araujo Santos on 10/08/22.
//

import Foundation

enum NetworkError: Error {
    case error(Error)
    case urlGeneration
}

public enum HTTPMethodType: String {
    case get    = "GET"
    case post   = "POST"
}

protocol NetworkServiceProtocol {
    func request(path: String, httpMethod: HTTPMethodType, body: [String: Any]) async -> Result<Data, Error>
}

public class NetworkService: NetworkServiceProtocol {
    public init() {}

    public func request(path: String, httpMethod: HTTPMethodType, body: [String: Any]) async -> Result<Data, Error> {
        // make url
        guard var urlComponents = URLComponents(string: "http://localhost:3001") else {
            return .failure(NetworkError.urlGeneration)
        }
        urlComponents.path = path

        guard let url = urlComponents.url else {
            return .failure(NetworkError.urlGeneration)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue

        // make body in JSON
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body)
            urlRequest.httpBody = jsonData
        } catch {
            return .failure(NetworkError.error(error))
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
