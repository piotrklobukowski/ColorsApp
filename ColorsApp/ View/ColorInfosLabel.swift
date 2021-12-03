//
//  ColorInfosLabel.swift
//  ColorsApp
//
//  Created by Piotr Kłobukowski on 02/12/2021.
//

import UIKit

class ColorInfosLabel: UILabel {

    var colorInfo = String() {
        didSet {
            textTransition(withText: colorInfo)
        }
    }
    
    var animationDuration: TimeInterval = 0.0
    
    private func textTransition(withText text: String) {
        UIView.animate(withDuration: animationDuration/2) {
            self.alpha = 0
        } completion: { _ in
            self.text = text
            UIView.animate(withDuration: self.animationDuration/2) {
                self.alpha = 1
            }
        }
    }

}
