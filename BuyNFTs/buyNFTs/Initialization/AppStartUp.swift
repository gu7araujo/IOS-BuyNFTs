//
//  AppStartUp.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 10/10/22.
//

import Foundation

class AppStartUp {

    static func start() {
        let environment = getEnv()

        let initializers: [InitializerProtocol] = [
            AuthInitializer(environment: environment)
        ]

        initializers.forEach { it in
            it.start()
        }
    }

    static func getEnv() -> Environments {
        guard let rawEnvironment = Bundle.main.object(forInfoDictionaryKey: "Environment") as? String else {
            return .development
        }

        return Environments(rawValue: rawEnvironment) ?? .development
    }

}









