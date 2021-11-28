//
//  ColorData.swift
//  ColorsApp
//
//  Created by Piotr Kłobukowski on 27/11/2021.
//

import Foundation

struct ColorData: Decodable {
    let rgb: Rgb
    let nameInfos: ColorName
    
    enum CodingKeys: String, CodingKey {
        case nameInfos = "name"
        case rgb
    }
}
