//
//  ColorDataModel.swift
//  ColorsApp
//
//  Created by Piotr Kłobukowski on 28/11/2021.
//

import Foundation
import UIKit

struct ColorViewData {
    
    init(red: Double, green: Double, blue: Double, name: String, hex: String, id: UUID?) {
        color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        self.name = name
        self.hex = hex
        
        if let id = id {
            self.id = id
        } else {
            self.id = nil
        }
    }
    
    let id: UUID?
    let color: UIColor
    let name: String
    let hex: String
}
