//
//  DataPersistenceService.swift
//  ColorsApp
//
//  Created by Piotr Kłobukowski on 02/12/2021.
//

import Foundation
import CoreData

protocol DataPersistenceProviding {
    func save(data: ColorData)
    func loadData() throws -> [Color]
    func delete(data: Color)
}

class DataPersistenceProvider: DataPersistenceProviding {
    
    let manager = CoreDataManager.shared
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    func save(data: ColorData) {
        let color = Color(context: context)
        let rgb = Rgb(context: context)
        
        rgb.red = data.rgb.fraction.r
        rgb.blue = data.rgb.fraction.b
        rgb.green = data.rgb.fraction.g
        color.name = data.nameInfos.name
        color.closestHexName = data.nameInfos.closestNamedHex
        color.id = UUID()
        color.rgb = rgb
        manager.saveContext()
    }
    
    func loadData() throws -> [Color] {
        let request: NSFetchRequest<Color> = Color.fetchRequest()
        let loadedColors: [Color] = try context.fetch(request)
        return loadedColors
    }
    
    func delete(data: Color) {
        if let rgbToDelete = data.rgb {
            context.delete(rgbToDelete)
        }
        context.delete(data)
        manager.saveContext()
    }
    
}
