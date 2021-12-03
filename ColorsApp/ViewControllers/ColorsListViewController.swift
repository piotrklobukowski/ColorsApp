//
//  ColorsListViewController.swift
//  ColorsApp
//
//  Created by Piotr Kłobukowski on 27/11/2021.
//

import UIKit

class ColorsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let colorsListViewModel = ColorsListViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        colorsListViewModel.loadColorsFromCoreData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ColorTableViewCell", bundle: nil), forCellReuseIdentifier: "ColorTableViewCell")
        tableView.dataSource = colorsListViewModel
        tableView.delegate = colorsListViewModel
        
        tableView.reloadData()
        colorsListViewModel.didLoadHandler = { [weak self] loadError in
            if let error = loadError {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                self?.present(alert, animated: true)
            } else {
                self?.tableView.reloadData()
            }
        }
        colorsListViewModel.didSelectRowHandler = { [weak self] colorViewData in
            self?.performSegue(withIdentifier: "showFavouriteColor", sender: colorViewData)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorViewData = sender as? ColorViewData else { return }
        if segue.identifier == "showFavouriteColor" {
            guard let destinationVC = segue.destination as? ColorViewController else { return }
            destinationVC.role = .favouriteColorPresenter(colorViewData: colorViewData)
        }
    }
}



