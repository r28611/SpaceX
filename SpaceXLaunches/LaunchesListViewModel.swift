//
//  LaunchesListViewModel.swift
//  SpaceXLaunches
//
//  Created by Margarita Novokhatskaia on 08/09/2022.
//

import Foundation

protocol LaunchesListViewModelDelegate: AnyObject {
    func onFetchCompleted()
}

final class LaunchesListViewModel {
    private weak var delegate: LaunchesListViewModelDelegate?
    private let networkService = NetworkService()
    private var launches: [Launch] = []
    
    init(delegate: LaunchesListViewModelDelegate) {
        self.delegate = delegate
    }
    
    var count: Int {
        return launches.count
    }
    
    func launch(at index: Int) -> Launch {
        return launches[index]
    }
    
    func fetchLaunches() {

        networkService.getLatestLaunches() { launches in
            DispatchQueue.main.async {
                self.launches.append(contentsOf: launches)
                self.delegate?.onFetchCompleted()
            }
        }
    }
}
