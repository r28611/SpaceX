//
//  LaunchesCellView.swift
//  SpaceXLaunches
//
//  Created by Margarita Novokhatskaia on 08/09/2022.
//

import UIKit

final class LaunchesCellView: UIView {
    
    var launchEntry: Launch? {
        willSet(item) {
            if let item = item {
                self.headlineLabel.text = item.name
                self.descriptionLabel.text = "Flight #\(item.flightNumber)"
                
                if let url = item.links.patch.small {
                    imageDownloader.downloadImage(url: url) { [weak self] downloadedImage in
                        guard let self = self,
                              let image = downloadedImage else { return }
                        DispatchQueue.main.async {
                            self.image.image = image
                        }
                    }
                }
            } else {
                self.headlineLabel.text = nil
                self.descriptionLabel.text = nil
                self.image.image = nil
            }
        }
    }
    
    private let imageDownloader = ImageDownloader()
    private let cornerRadius: CGFloat = 16.0
    
    // MARK: - Subviews
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.systemGray6
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let headlineLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [headlineLabel, descriptionLabel])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setShadow()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addViews()
        setupConstraints()
        containerView.layer.cornerRadius = cornerRadius
    }
    
    private func addViews() {
        addSubview(containerView)
        containerView.addSubview(image)
        containerView.addSubview(stackView)
    }
    
    private func setShadow() {
        layer.shadowPath = UIBezierPath(roundedRect: containerView.frame, cornerRadius: cornerRadius).cgPath
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 3.0
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            headlineLabel.heightAnchor.constraint(equalToConstant: 24),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 24),
        ])
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: containerView.topAnchor),
            image.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 220)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
}

