//
//  ColorName.swift
//  ColorsApp
//
//  Created by Piotr Kłobukowski on 27/11/2021.
//

import Foundation

struct ColorName: Decodable {
    let name: String
    let closestNamedHex: String
    
    enum CodingKeys: String, CodingKey {
        case name = "value"
        case closestNamedHex
    }
}
