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
    private var mainScrollView: UIScrollView!
    private var contentView: UIView!
    private var scrollView: UIScrollView!
    private var pageControl: UIPageControl!
    
    init(data: PlacesModel) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        title = ""
        mainScrollView = UIScrollView(frame: view.frame)
        contentView = UIView(frame: view.frame)
        mainScrollView.contentSize = contentView.bounds.size
        mainScrollView.showsVerticalScrollIndicator = false
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(contentView)
        setupUI()
        addData()
    }
    
    private func addData() {
        
        scrollView.contentSize = CGSize(width: CGFloat(data.images.count) * view.frame.size.width, height: view.frame.size.height / 3)
        
        for (index, img) in data.images.enumerated() {
            guard let url = URL(string: img) else { return }
            let imgView = UIImageView(frame: CGRect(x: CGFloat(index) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height / 3))
                imgView.kf.indicatorType = .activity
                imgView.kf.setImage(with: url)
            scrollView.addSubview(imgView)
        }
        pageControl.numberOfPages = data.images.count
        createDateLabel.text = "Дата публікацыі: " + data.creation_date.replacingOccurrences(of: "-", with: ".")
        descriptionLabel.text = .init(htmlEncodedString: data.text ?? "")
        titleLabel.text = data.name
    }
}

extension DetailViewController {
    private func setupUI() {
        scrollView = UIScrollView()
        createDateLabel = UILabel()
        descriptionLabel = UILabel()
        titleLabel = UILabel()
        
        contentView.addSubview(scrollView)
        contentView.addSubview(createDateLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(titleLabel)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        createDateLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
//        descriptionLabel.contentMode = .scaleAspectFit
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        
        pageControl = UIPageControl()
        contentView.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
        
        let guide = contentView.safeAreaLayoutGuide
        let spacing = CGFloat(16)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: view.frame.width),
            contentView.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
            contentView.leftAnchor.constraint(equalTo: mainScrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: mainScrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor),
            
            scrollView.heightAnchor.constraint(equalToConstant: view.frame.height / 3),
            scrollView.topAnchor.constraint(equalTo: guide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: guide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: guide.rightAnchor),
            
            pageControl.leftAnchor.constraint(equalTo: guide.leftAnchor),
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 8),
            pageControl.rightAnchor.constraint(equalTo: guide.rightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: spacing),
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

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floor(Float(scrollView.contentOffset.x / scrollView.frame.size.width)))
    }
}
