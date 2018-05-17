//
//  Extension.swift
//  themoviedb
//
//  Created by Mauricio Figueroa olivares on 16-05-18.
//  Copyright © 2018 Mauricio Figueroa olivares. All rights reserved.
//

import Foundation
import UIKit
import AVKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingRight: CGFloat, paddingBottom: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        if let topAnchor = top {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop).isActive = true
        }
        
        if let leftAnchor = left {
            self.leftAnchor.constraint(equalTo: leftAnchor, constant: paddingLeft).isActive = true
        }
        
        if let rightAnchor = right {
            self.rightAnchor.constraint(equalTo: rightAnchor, constant: -paddingRight).isActive = true
        }
        
        if let bottomAnchor = bottom {
            self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -paddingBottom).isActive = true
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
