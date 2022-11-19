//
//  Colors.swift
//  buyNFTs-DEV
//
//  Created by Gustavo Araujo Santos on 13/10/22.
//

import UIKit

public enum Colors: RawRepresentable {

    public typealias RawValue = UIColor?

    case happiness
    case white
    case cloud

    public init?(rawValue: RawValue) {
        switch rawValue {
        case UIColor(hex: "#2E2EFF"): self = .happiness
        case UIColor(hex: "#FFFFFF"): self = .white
        case UIColor(hex: "#F5F5F5"): self = .cloud
        default: return nil
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .happiness: return UIColor(hex: "#2E2EFF")
        case .white: return UIColor(hex: "#FFFFFF")
        case .cloud: return UIColor(hex: "#F5F5F5")
        }
    }

}
