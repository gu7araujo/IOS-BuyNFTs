//
//  Environments.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 10/10/22.
//

enum Environments: String {

    case development = "DEV"
    case production = "PROD"

    public var serviceAPIKey: String {
        switch self {
        case .development: return EnvironmentDevelopmentVariables.serviceAPIKey
        case .production: return EnvironmentProductionVariables.serviceAPIKey
        }
    }

}
