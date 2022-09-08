//
//  LaunchesCell.swift
//  SpaceXLaunches
//
//  Created by Margarita Novokhatskaia on 08/09/2022.
//

import UIKit

final class LaunchesCell: UITableViewCell {
    
    static let reuseIdentifier = "LaunchesCell"
    
    let view = LaunchesCellView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        view.launchEntry = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }, completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.transform = .identity
                }
            })
        }
    }
    
    func configure(model: Launch?) {
        view.launchEntry = model
    }
    
    // MARK: - UI
    
    private func configureUI() {
        addSubview(view)
        selectionStyle = .none
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}

