//
//  UIFont+Extension.swift
//  BuyNFTs
//
//  Created by Gustavo Araujo Santos on 11/10/22.
//

import UIKit

extension UIFont {

    enum Family: String, CaseIterable {
        case roboto = "Roboto"

        static let defaultFamily = Family.roboto
    }

    enum CustomWeight: String, CaseIterable {
        case Light, Regular, Bold
    }

    enum Size: CGFloat, CaseIterable {
        case h1 = 28, h2 = 22, h3 = 18, h4 = 16
        case p1 = 14, p2 = 12, p3 = 10
    }

    convenience init?(size: Size,
                      weight: CustomWeight) {
        self.init(family: .defaultFamily, size: size, weight: weight)
    }

    convenience init?(family: Family = .defaultFamily,
                      size: Size,
                      weight: CustomWeight) {
        self.init(name: UIFont.stringName(family: family, weight: weight), size: size.rawValue)
    }

    internal class func stringName(family: Family = .defaultFamily,
                                   weight: CustomWeight = .Regular) -> String {

        let fontWeight = weight.rawValue
        let familyName = family.rawValue

        return "\(familyName)-\(fontWeight)"
    }

    internal static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {

        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension) else {
            fatalError("Couldn't find font \(fontName)")
        }

        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
            fatalError("Couldn't load data from the font \(fontName)")
        }

        guard let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }

        var error: Unmanaged<CFError>?
        _ = CTFontManagerRegisterGraphicsFont(font, &error)
    }

}
