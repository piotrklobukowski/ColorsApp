//
//  ColorsListViewModel.swift
//  ColorsApp
//
//  Created by Piotr Kłobukowski on 30/11/2021.
//

import Foundation
import CoreData
import UIKit

class ColorsListViewModel: NSObject {
    
    private let dataPersistenceProvider: DataPersistenceProviding = DataPersistenceProvider()
    private var colors: [Color] = []
    private var colorsViewData: [ColorViewData] = []
    
    var didLoadHandler: ( (Error?) -> () )?
    var didSelectRowHandler: ( (ColorViewData) -> () )?
    
    func loadColorsFromCoreData() {
        do {
            colors = try dataPersistenceProvider.loadData()
            colorsViewData = colors.compactMap({ coreDataColor in
                createColorViewData(withData: coreDataColor)
            })
            didLoadHandler?(nil)
        } catch {
            didLoadHandler?(error)
        }
    }
    
    func deleteFromCoreData(colorViewData: ColorViewData) {
        let colorToDelete = colors.first { color in
            colorViewData.id == color.id
        }
        if let colorToDelete = colorToDelete {
            dataPersistenceProvider.delete(data: colorToDelete)
        }
    }
    
    private func createColorViewData(withData data: Color) -> ColorViewData? {
        
        guard let rgb = data.rgb, let id = data.id, let hex = data.closestHexName, let name = data.name else { return nil }
        let red = rgb.red
        let green = rgb.green
        let blue = rgb.blue
        
        return ColorViewData(red: red, green: green, blue: blue, name: name, hex: hex, id: id)
    }
}

extension ColorsListViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewData = colorsViewData[indexPath.row]
        didSelectRowHandler?(cellViewData)
    }
}

extension ColorsListViewModel: UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorsViewData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorTableViewCell", for: indexPath) as! ColorTableViewCell
        cell.nameLabel.text = colorsViewData[indexPath.row].name
        cell.hexLabel.text = colorsViewData[indexPath.row].hex
        cell.colorContainer.color = colorsViewData[indexPath.row].color
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteFromCoreData(colorViewData: colorsViewData[indexPath.row])
            colorsViewData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
