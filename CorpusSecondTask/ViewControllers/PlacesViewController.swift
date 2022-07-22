//
//  PlacesViewController.swift
//  CorpusSecondTask
//
//  Created by Vlad Ralovich on 22.07.22.
//

import UIKit

class PlacesViewController: UIViewController {
    
    var activityView = UIActivityIndicatorView()
    var townsTableView = ListTableView()
    var currentTown: TownModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = currentTown.name
        setupTableView()
        if townsTableView.places.isEmpty { setupActivityView() }
    }
    
    private func setupTableView() {
        townsTableView.frame = view.frame
        townsTableView.isShowTownsList = false
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
}

extension PlacesViewController: TownViewControllerDelegate {
    func loadedPlaces(places: [PlacesModel]?) {
        townsTableView.places = places!.filter({$0.city_id == currentTown.id}) //!!!!!!
        townsTableView.reloadData()
        activityView.stopAnimating()
    }
}

extension PlacesViewController: ListTableViewDelegate {
    func selectCell(indexPath: IndexPath) {
        print("new VC \(townsTableView.places[indexPath.row].name)")
    }
}
