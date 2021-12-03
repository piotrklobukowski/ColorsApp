//
//  ColorViewController.swift
//  ColorsApp
//
//  Created by Piotr Kłobukowski on 27/11/2021.
//

import UIKit

class ColorViewController: UIViewController {
    
    @IBOutlet weak var textLabel: ColorInfosLabel!
    @IBOutlet weak var colorContainer: ColorContainer!
    @IBOutlet weak var buttonsStackView: UIStackView!
    
    let colorGeneratorViewModel = ColorGeneratorViewModel()
    var role: ViewControllerRole = .generator
    
    enum ViewControllerRole {
        case generator
        case favouriteColorPresenter(colorViewData: ColorViewData)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch role {
        case .generator:
            buttonsStackView.isHidden = false
            let animationDuration = 0.5
            colorContainer.animationDuration = animationDuration
            textLabel.animationDuration = animationDuration
            colorGeneratorViewModel.didLoadHandler = { [weak self] colorViewModel in
                self?.colorContainer.color = colorViewModel.color
                self?.textLabel.colorInfo = colorViewModel.name + " " + colorViewModel.hex
            }
        case .favouriteColorPresenter(let colorViewModel):
            title = colorViewModel.name
            buttonsStackView.isHidden = true
            colorContainer.color = colorViewModel.color
            textLabel.text = colorViewModel.name + " " + colorViewModel.hex
        }
    }
    
    @IBAction func generateButtonPressed(_ sender: UIButton) {
        colorGeneratorViewModel.fetchColorData()
    }
    
    @IBAction func SaveButtonPressed(_ sender: UIButton) {
        colorGeneratorViewModel.transferToSave()
    }
}
