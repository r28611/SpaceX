//
//  LaunchesListView.swift
//  SpaceXLaunches
//
//  Created by Margarita Novokhatskaia on 08/09/2022.
//

import UIKit

final class LaunchesListView: UIView {
    
    // MARK: - Subviews
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Space X Launches"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = 340
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(LaunchesCell.self, forCellReuseIdentifier: LaunchesCell.reuseIdentifier)
        return tableView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }
    
    // MARK: - UI
    
    private func configureUI() {
        backgroundColor = UIColor.white
        addViews()
        setupConstraints()
    }
    
    private func addViews() {
        addSubview(titleLabel)
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        let margins = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: margins.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16),
            
            tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -8),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
}
