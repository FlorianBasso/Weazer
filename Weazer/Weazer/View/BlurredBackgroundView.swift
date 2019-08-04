//
//  BlurredBackgroundView.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import UIKit

class BlurredBackgroundView: UIView {
    let imageView: UIImageView
    let blurView: UIVisualEffectView
    
    override init(frame: CGRect) {
        let blurEffect = UIBlurEffect(style: .dark)
        self.blurView = UIVisualEffectView(effect: blurEffect)
        self.imageView = UIImageView(image: UIImage(named: "gorgeousimage")!)
        super.init(frame: frame)
        self.addSubview(imageView)
        self.addSubview(blurView)
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init(frame: CGRect.zero)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = bounds
        self.blurView.frame = bounds
    }
}
