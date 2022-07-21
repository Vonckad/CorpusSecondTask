//
//  TownViewController.swift
//  CorpusSecondTask
//
//  Created by Vlad Ralovich on 21.07.22.
//

import UIKit
import Alamofire

class TownViewController: UIViewController {
    
    var isShowTownsList = true
    private var townsTableView = UITableView()
    private var towns: [TownModel] = [] {
        didSet {
            townsTableView.reloadData()
        }
    }
    var places: [PlacesModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        if isShowTownsList {
            title = "Вылучыце горад"
            loadTowns()
        }
    }
    
    private func loadTowns() {
        AF.request("https://krokapp.by/api/get_cities/11/").responseDecodable(of: [TownModel].self) { [weak self] response in
            guard let value = response.value else { return }
            self?.towns = value.filter({$0.lang == 1})
        }
        AF.request("https://krokapp.by/api/get_points/11/").responseDecodable(of: [PlacesModel].self) { [weak self] response in
            guard let value = response.value else {
                print("Error")
                return
            }
            self?.places = value.filter({$0.lang == 1})
        }
    }
    
    private func setupTableView() {
        townsTableView.dataSource = self
        townsTableView.delegate = self
        townsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "townCell")
        townsTableView.translatesAutoresizingMaskIntoConstraints = false
        townsTableView.backgroundColor = .clear
        view.addSubview(townsTableView)
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            townsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            townsTableView.leftAnchor.constraint(equalTo: guide.leftAnchor),
            townsTableView.rightAnchor.constraint(equalTo: guide.rightAnchor),
            townsTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
}

extension TownViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isShowTownsList ? towns.count : places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "townCell", for: indexPath)
        cell.textLabel?.text = isShowTownsList ? towns[indexPath.row].name : places[indexPath.row].name
        cell.backgroundColor = .clear
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        townsTableView.deselectRow(at: indexPath, animated: true)
        if isShowTownsList {
            let placesVC = TownViewController()
            placesVC.isShowTownsList = false
            placesVC.title = towns[indexPath.row].name
            placesVC.places = places.filter({$0.city_id == towns[indexPath.row].id})
            navigationController?.pushViewController(placesVC, animated: true)
        } else {
            print("last VC \(places[indexPath.row].name)")
        }
    }
}

