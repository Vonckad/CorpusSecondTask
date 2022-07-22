//
//  DetailViewController.swift
//  CorpusSecondTask
//
//  Created by Vlad Ralovich on 23.07.22.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    private var data: PlacesModel
    private var titleLabel: UILabel!
    private var createDateLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var imageView: UIImageView!
    
    init(data: PlacesModel) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = UIColor(red: 238/255, green: 235/255, blue: 248/255, alpha: 1)
        setupUI()
        addData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    private func addData() {
        guard let url = URL(string: data.images?.first ?? "") else { return }
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url)
        title = ""
        createDateLabel.text = data.creation_date
        descriptionLabel.text = .init(htmlEncodedString: data.text ?? "")
        titleLabel.text = data.name
    }
}

extension DetailViewController {
    private func setupUI() {
        imageView = UIImageView()
        createDateLabel = UILabel()
        descriptionLabel = UILabel()
        titleLabel = UILabel()
        
        view.addSubview(imageView)
        view.addSubview(createDateLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(titleLabel)
//        titleLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        createDateLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFit
        descriptionLabel.numberOfLines = 0
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        let guide = view.safeAreaLayoutGuide
        let spacing = CGFloat(16)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: view.frame.height / 3),
            imageView.topAnchor.constraint(equalTo: guide.topAnchor),
            imageView.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: spacing),
            imageView.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -spacing),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: spacing),
            titleLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: spacing),
            titleLabel.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -spacing),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
            descriptionLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: spacing),
            descriptionLabel.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -spacing),
            
            createDateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: spacing),
            createDateLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: spacing),
            createDateLabel.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -spacing),
            createDateLabel.bottomAnchor.constraint(lessThanOrEqualTo: guide.bottomAnchor, constant: -spacing)
        ])
    }
}
