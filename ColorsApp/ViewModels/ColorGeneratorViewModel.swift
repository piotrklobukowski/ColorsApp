//
//  ColorGeneratorViewModel.swift
//  ColorsApp
//
//  Created by Piotr Kłobukowski on 28/11/2021.
//

import Foundation
import UIKit

class ColorGeneratorViewModel: NSObject {
    private let dataPersistenceProvider: DataPersistenceProviding = DataPersistenceProvider()
    private let colorsAPIService = ColorsAPIService()
    private var colorViewData: ColorViewData? {
        didSet {
            if let colorViewModel = colorViewData {
                didLoadHandler?(colorViewModel)
            }
        }
    }
    private var colorData: ColorData?
    
    var didLoadHandler: ((ColorViewData) -> Void)?
    
    func fetchColorData() {
        let rgb = RgbRandomizer.randomizeRgbValues()
        colorsAPIService.getColorData(red: rgb.red, green: rgb.green, blue: rgb.blue) { [weak self] data in
            self?.colorData = data
            let viewModel = self?.createColorViewData(withData: data)
            DispatchQueue.main.async {
                self?.colorViewData = viewModel
            }
        }
    }
    
    func transferToSave() {
        guard let colorData = colorData else {
            return
        }
        dataPersistenceProvider.save(data: colorData)
    }
    
    private func createColorViewData(withData data: ColorData) -> ColorViewData {
        let red = data.rgb.fraction.r
        let green = data.rgb.fraction.g
        let blue = data.rgb.fraction.b
        let name = data.nameInfos.name
        let hex = data.nameInfos.closestNamedHex
        
        return ColorViewData(red: red, green: green, blue: blue, name: name, hex: hex, id: nil)
    }
    
}
