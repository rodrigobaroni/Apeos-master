//
//  UIFont+ItalicBold.swift
//  Apeos
//
//  Created by v.franca.nunes.silva on 16/06/19.
//  Copyright © 2019 Rodrigo Alexis Garcia Baroni. All rights reserved.
//

import UIKit

extension UIFont {
    
    public static func withItalicAndBold(ofSize: CGFloat) -> UIFont {
        guard let descriptor = UIFontDescriptor().withSymbolicTraits([.traitItalic, .traitBold]) else {
            return UIFont.systemFont(ofSize: ofSize)
        }
        return UIFont(descriptor: descriptor, size: ofSize)
    }
    
}
