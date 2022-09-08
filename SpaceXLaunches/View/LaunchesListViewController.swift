//
//  LaunchesListViewController.swift
//  SpaceXLaunches
//
//  Created by Margarita Novokhatskaia on 08/09/2022.
//

import UIKit

final class LaunchesListViewController: UIViewController {
    private var launchesListView: LaunchesListView {
        return self.view as! LaunchesListView
    }
    
    private var viewModel: LaunchesListViewModel!
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = LaunchesListView()
        setupTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LaunchesListViewModel(delegate: self)
        viewModel.fetchLaunches()
    }
    
    private func setupTableView() {
        launchesListView.tableView.dataSource = self
        launchesListView.tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource

extension LaunchesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LaunchesCell.reuseIdentifier,
                                                       for: indexPath) as? LaunchesCell
        else { return LaunchesCell() }
        
        cell.configure(model: viewModel.launch(at: indexPath.row))
        
        return cell
    }
}

extension LaunchesListViewController: LaunchesListViewModelDelegate {
    func onFetchCompleted() {
        launchesListView.tableView.reloadData()
    }
}
