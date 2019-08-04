//
//  ImageManager.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import UIKit

typealias ImageCacheCompletionBlock = (Bool) -> Void
typealias ImageCompletionBlock = (UIImage?, Error?, URL?) -> Void

protocol ImageManager {
    
    func url(icon: String) -> URL?
    
    func doesImageExistsOnDisk(for url: URL?,
                                              completion completionBlock: ImageCacheCompletionBlock?)
    
    func setImageWith(_ url: URL?,
                                     on imageView: UIImageView?,
                                     placeholderImage placeholder: UIImage?,
                                     completed completedBlock: ImageCompletionBlock?)
    
    func cancelCurrentImageLoad(on imageView: UIImageView?)
}
