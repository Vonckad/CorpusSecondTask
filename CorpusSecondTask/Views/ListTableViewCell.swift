//
//  ListTableViewCell.swift
//  CorpusSecondTask
//
//  Created by Vlad Ralovich on 22.07.22.
//

import Foundation
import UIKit

class ListTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "list-cell-reuse-identifier"
    let view = UIView()
    let myImageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
//        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addData(title: String, urlImage: String) {
        titleLabel.text = title
        print("urlImage = \(urlImage)")
    }
}

extension ListTableViewCell {
    private func configure() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(view)
        view.addSubview(myImageView)
        view.addSubview(titleLabel)
        
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        
        let spacing = CGFloat(24)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing),
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: spacing),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -spacing),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spacing),
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: myImageView.leftAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            myImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -11),
            myImageView.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            
            myImageView.widthAnchor.constraint(equalToConstant: 42),
            myImageView.heightAnchor.constraint(equalToConstant: 42),
        ])
    }
}
