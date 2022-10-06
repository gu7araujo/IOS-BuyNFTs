//
//  UIImageView+Extension.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 08/09/22.
//

import UIKit
import Kingfisher

extension UIImageView {

    private struct Holder {
        static var cache: ImageCache?
    }

    func loadImage(url: String) {
        let url = URL(string: url)
        KF.url(url)
            .targetCache(getCache())
            .set(to: self)
    }

    private func getCache() -> ImageCache {
        let cache = Holder.cache ?? ImageCache(name: "images")
        if Holder.cache == nil {
            cache.diskStorage.config.sizeLimit = 100 * 1024 * 1024 // 100MB
            Holder.cache = cache
        }
        return cache
    }

}
