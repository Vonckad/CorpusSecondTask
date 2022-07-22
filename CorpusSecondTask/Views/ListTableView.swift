//
//  ListTableView.swift
//  CorpusSecondTask
//
//  Created by Vlad Ralovich on 22.07.22.
//

import Foundation
import UIKit

protocol ListTableViewDelegate {
    func selectCell(indexPath: IndexPath)
}

class ListTableView: UITableView {
    
    var isShowTownsList = true
    var towns: [TownModel] = [] {
        didSet {
            reloadData()
        }
    }
    var places: [PlacesModel] = []
    var listDelegate: ListTableViewDelegate?
    
    init() {
        super.init(frame: .zero, style: .plain)
        delegate = self
        dataSource = self
        register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
//        rowHeight = UITableView.automaticDimension
//        estimatedRowHeight = 600
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isShowTownsList ? towns.count : places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as! ListTableViewCell
        if isShowTownsList {
            let town = towns[indexPath.row]
            cell.addData(title: town.name, urlImage: town.logo)
        } else {
            let place = places[indexPath.row]
            cell.addData(title: place.name, urlImage: place.logo ?? "")
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if let cell = cell as? ListTableViewCell { cell.cancelDownloadTask() }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listDelegate?.selectCell(indexPath: indexPath)
        deselectRow(at: indexPath, animated: true)
    }
}
