//
//  ColorViewController.swift
//  ColorsApp
//
//  Created by Piotr Kłobukowski on 27/11/2021.
//

import UIKit

class ColorViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var colorContainer: ColorContainer!
    let networkingViewModel = ColorNetworkingViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        networkingViewModel.didLoadHandler = { [weak self] colorViewModel in
            self?.colorContainer.backgroundColor = UIColor(red: colorViewModel.red, green: colorViewModel.green, blue: colorViewModel.blue, alpha: 1.0)
            self?.textLabel.text = colorViewModel.name + " " + colorViewModel.hex
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func generateColor(_ sender: UIButton) {
        networkingViewModel.fetchColorData()
    }
    
    @IBAction func saveColor(_ sender: UIButton) {
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
