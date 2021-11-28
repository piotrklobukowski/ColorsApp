//
//  RgbRandomizer.swift
//  ColorsApp
//
//  Created by Piotr Kłobukowski on 28/11/2021.
//

import Foundation

struct RgbRandomizer {
    static let rgbRange = 0...255
    
    static func randomizeRgbValues() -> (red: Int, green: Int, blue: Int) {
        let red = Int.random(in: rgbRange)
        let green = Int.random(in: rgbRange)
        let blue = Int.random(in: rgbRange)
        return (red, green, blue)
    }
}
