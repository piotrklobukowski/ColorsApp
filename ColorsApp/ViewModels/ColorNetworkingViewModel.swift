//
//  ColorNetworkingViewModel.swift
//  ColorsApp
//
//  Created by Piotr Kłobukowski on 28/11/2021.
//

import Foundation
import CoreGraphics

class ColorNetworkingViewModel: NSObject {
    private let colorsAPIService = ColorsAPIService()
    private var colorViewModel: ColorViewModel? {
        didSet {
            if let colorViewModel = colorViewModel {
                didLoadHandler?(colorViewModel)
            }
        }
    }
    
    var didLoadHandler: ((ColorViewModel) -> Void)?
    
    func fetchColorData() {
        let rgb = RgbRandomizer.randomizeRgbValues()
        colorsAPIService.getColorData(red: rgb.red, green: rgb.green, blue: rgb.blue) { [weak self] data in
            let viewModel = self?.colorViewModelFactory(withData: data)
            DispatchQueue.main.async {
                self?.colorViewModel = viewModel
            }
        }
    }
    
    private func colorViewModelFactory(withData data: ColorData) -> ColorViewModel {
        let red = CGFloat(data.rgb.fraction.r)
        let green = CGFloat(data.rgb.fraction.g)
        let blue = CGFloat(data.rgb.fraction.b)
        let name = data.nameInfos.name
        let hex = data.nameInfos.closestNamedHex
        
        return ColorViewModel(red: red, green: green, blue: blue, name: name, hex: hex)
    }
    
}
