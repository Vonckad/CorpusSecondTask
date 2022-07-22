//
//  ListTableViewCell.swift
//  CorpusSecondTask
//
//  Created by Vlad Ralovich on 22.07.22.
//

import Foundation
import UIKit
import Kingfisher

class ListTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "list-cell-reuse-identifier"
    let view = UIView()
    let myImageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addData(title: String, urlImage: String) {
        titleLabel.text = title
        myImageView.kf.indicatorType = .activity
        guard let url = URL(string: urlImage) else { return }
        KF.url(url)
            .fade(duration: 1)
            .set(to: myImageView)
    }
}

extension ListTableViewCell {
    private func configure() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        
        myImageView.contentMode = .scaleAspectFit
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(view)
        view.addSubview(myImageView)
        view.addSubview(titleLabel)
        
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        
        let spacing = CGFloat(24)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing),
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: spacing),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -spacing),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spacing),
            
            myImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            myImageView.topAnchor.constraint(equalTo: view.topAnchor),
            myImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            myImageView.widthAnchor.constraint(equalToConstant: 80),
            myImageView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            titleLabel.leftAnchor.constraint(equalTo: myImageView.rightAnchor, constant: spacing),
            titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
