//
//  ColorContainer.swift
//  ColorsApp
//
//  Created by Piotr Kłobukowski on 27/11/2021.
//

import UIKit

@IBDesignable
class ColorContainer: UIView {
    
    var color: UIColor = .black {
        didSet {
            colorTransition(toNewColor: color)
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    var animationDuration: TimeInterval = 0.0
    
    private func colorTransition(toNewColor newColor: UIColor) {
        UIView.animate(withDuration: animationDuration) {
            self.backgroundColor = newColor
        }
    }

}
