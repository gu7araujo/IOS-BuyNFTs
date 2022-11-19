//
//  Typography.swift
//  buyNFTs-DEV
//
//  Created by Gustavo Araujo Santos on 11/10/22.
//

import UIKit

public enum Typography: RawRepresentable {

    public typealias RawValue = UIFont

    public init?(rawValue: UIFont) {
        return nil
    }

    case h1
    case h1Bold
    case h2
    case h2Bold
    case h3
    case h3Bold
    case h4
    case h4Bold
    case p1
    case p1Bold
    case p1Light
    case p2
    case p2Bold
    case p2Light
    case p3
    case p3Bold
    case p3Light

    public var rawValue: UIFont {
        var value: UIFont?
        switch self {
        case .h1:
            value = UIFont(size: .h1, weight: .Regular)
        case .h1Bold:
            value = UIFont(size: .h1, weight: .Bold)
        case .h2:
            value = UIFont(size: .h2, weight: .Regular)
        case .h2Bold:
            value = UIFont(size: .h2, weight: .Bold)
        case .h3:
            value = UIFont(size: .h3, weight: .Regular)
        case .h3Bold:
            value = UIFont(size: .h3, weight: .Bold)
        case .h4:
            value = UIFont(size: .h4, weight: .Regular)
        case .h4Bold:
            value = UIFont(size: .h4, weight: .Bold)
        case .p1:
            value = UIFont(size: .p1, weight: .Regular)
        case .p1Bold:
            value = UIFont(size: .p1, weight: .Bold)
        case .p1Light:
            value = UIFont(size: .p1, weight: .Light)
        case .p2:
            value = UIFont(size: .p2, weight: .Regular)
        case .p2Bold:
            value = UIFont(size: .p2, weight: .Bold)
        case .p2Light:
            value = UIFont(size: .p2, weight: .Light)
        case .p3:
            value = UIFont(size: .p3, weight: .Regular)
        case .p3Bold:
            value = UIFont(size: .p3, weight: .Bold)
        case .p3Light:
            value = UIFont(size: .p3, weight: .Light)
        }

        return value ?? UIFont()
    }

    private static let tcccFileName = UIFont.Family.roboto.rawValue

    public static func registerFontFamily() {
        guard let bundle = Bundle(identifier: "gusta.Shared") else {
            fatalError("Couldn't find bundle")
        }
        UIFont.registerFont(bundle: bundle, fontName: UIFont.stringName(weight: .Light), fontExtension: "ttf")
        UIFont.registerFont(bundle: bundle, fontName: UIFont.stringName(weight: .Regular), fontExtension: "ttf")
        UIFont.registerFont(bundle: bundle, fontName: UIFont.stringName(weight: .Bold), fontExtension: "ttf")
    }

}
