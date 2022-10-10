//
//  AuthInitializer.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 10/10/22.
//

class AuthInitializer: InitializerProtocol {

    let environment: Environments

    init(environment: Environments) {
        self.environment = environment
    }

    func start() {
        // do something
        print("service xyz api key: \(environment.serviceAPIKey)")
    }

}
