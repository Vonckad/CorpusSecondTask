//
//  TownViewController.swift
//  CorpusSecondTask
//
//  Created by Vlad Ralovich on 21.07.22.
//

import UIKit
import Alamofire

protocol TownViewControllerDelegate {
    func loadedPlaces(places: [PlacesModel]?)
}

class TownViewController: UIViewController {
    
    var activityView = UIActivityIndicatorView()
    var delegate: TownViewControllerDelegate?
    private var townsTableView = ListTableView()
    private var places: [PlacesModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonTitle = ""
        setupTableView()
        loadTowns()
        title = "Гарады"
    }
    
    private func loadTowns() {
        setupActivityView()
            AF.request("https://krokapp.by/api/get_cities/11/").responseDecodable(of: [TownModel].self) { [weak self] response in
                guard let value = response.value else {
                    self?.showAlert()
                    return
                }
                self?.townsTableView.towns = value.filter({$0.lang == 1})
                self?.activityView.stopAnimating()
            }
            AF.request("https://krokapp.by/api/get_points/11/").responseDecodable(of: [PlacesModel].self) { [weak self] response in
                guard let value = response.value else {
                    self?.showAlert()
                    return
                }
                self?.places = value.filter({$0.lang == 1})
                self?.delegate?.loadedPlaces(places: self?.places)
                self?.activityView.stopAnimating()
            }
    }
    
    private func setupTableView() {
        townsTableView.frame = view.frame
        townsTableView.listDelegate = self
        view.addSubview(townsTableView)
    }
    
    private func setupActivityView() {
        view.addSubview(activityView)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityView.hidesWhenStopped = true
        activityView.style = .large
        activityView.startAnimating()
    }
    private func showAlert() {
        let alert = UIAlertController(title: "Здарылася памылка", message: "Праверце подключэнне да інернета", preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Адмена", style: .destructive)
        let reloadAction = UIAlertAction(title: "Абнавіць", style: .default) { [weak self] _ in
            self?.loadTowns()
        }
        alert.addAction(actionCancel)
        alert.addAction(reloadAction)
        present(alert, animated: true)
    }
}

extension TownViewController: ListTableViewDelegate {
    func selectCell(indexPath: IndexPath) {
        let placesVC = PlacesViewController()
        placesVC.currentTown = townsTableView.towns[indexPath.row]
        if !places.isEmpty {
            placesVC.townsTableView.places = places.filter({$0.city_id == townsTableView.towns[indexPath.row].id})
        }
        delegate = placesVC
        navigationController?.pushViewController(placesVC, animated: true)
    }
}
