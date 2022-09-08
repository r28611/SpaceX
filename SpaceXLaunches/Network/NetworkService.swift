//
//  NetworkService.swift
//  SpaceXLaunches
//
//  Created by Margarita Novokhatskaia on 08/09/2022.
//

import Foundation

enum NetworkError: Error {
    case customError(localizedDescription: String)
}

struct NetworkService {
    
    private let urlSession = URLSession.shared
    private let decoder = JSONDecoder()
    private let latestLaunchesQueue = DispatchQueue(label: "latest.network.service.queue", qos: .userInitiated)
    private let baseURLString = "https://api.spacexdata.com/v4/"
    
    // MARK: - Methods
    
    func getLatestLaunches(result: @escaping ([Launch]) -> ()) {
        let path = "launches"
        guard let url = URL(string: baseURLString + path) else { return }
        let request = URLRequest(url: url)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        latestLaunchesQueue.async {
            urlSession.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    print(error.localizedDescription)
                }
                
                if let data = data {
                    do {
                        let launchesList = try decoder.decode([Launch].self, from: data)
                        result(launchesList)
                    } catch {
                        print(error, error.localizedDescription)
                    }
                }
            }.resume()
        }
    }
}
