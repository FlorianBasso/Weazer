//
//  ImageManager+SDWebImageManager.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import SDWebImage

// MARK: - YMMImageDownloader
extension SDWebImageManager: ImageManager {
    
    func url(icon: String) -> URL? {
        
        return URL(string: "https://openweathermap.org/img/w/\(icon).png")
    }
    
    func doesImageExistsOnDisk(for url: URL?,
                                      completion completionBlock: ImageCacheCompletionBlock? = nil) {
        self.diskImageExists(for: url) { (isInCache) in
            completionBlock?(isInCache)
        }
    }
    
     func setImageWith(_ url: URL?, on imageView: UIImageView?, placeholderImage placeholder: UIImage?, completed completedBlock: ImageCompletionBlock? = nil) {
        
        imageView?.sd_setImage(with: url,
                               placeholderImage: placeholder,
                               options: [.lowPriority], completed: { (image, error, cacheType, imageURL) in
                                completedBlock?(image, error, imageURL)
        })
    }
    
    func cancelCurrentImageLoad(on imageView: UIImageView?) {
        imageView?.sd_cancelCurrentImageLoad()
    }
    
}
