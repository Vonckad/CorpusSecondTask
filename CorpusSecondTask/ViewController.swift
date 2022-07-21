//
//  ViewController.swift
//  CorpusSecondTask
//
//  Created by Vlad Ralovich on 21.07.22.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    private var townsTableView = UITableView()
    private var towns: [TownModel] = [] {
        didSet {
            townsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main VC"
        view.backgroundColor = .brown
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        loadTowns()
    }
    
    private func loadTowns() {
        AF.request("https://krokapp.by/api/get_cities/11/").responseDecodable(of: [TownModel].self) { [weak self] response in
            guard let value = response.value else { return }
            self?.towns = value.filter({$0.lang == 1})
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

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return towns.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "townCell", for: indexPath)
        cell.textLabel?.text = towns[indexPath.row].name
        cell.backgroundColor = .clear
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select \(towns[indexPath.row].name) town")
        townsTableView.deselectRow(at: indexPath, animated: true)
    }
}

