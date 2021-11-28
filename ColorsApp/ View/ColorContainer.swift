//
//  ColorContainer.swift
//  ColorsApp
//
//  Created by Piotr Kłobukowski on 27/11/2021.
//

import UIKit

@IBDesignable
class ColorContainer: UIView {
        
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

}
