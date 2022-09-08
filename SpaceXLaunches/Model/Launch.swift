//
//  Launch.swift
//  SpaceXLaunches
//
//  Created by Margarita Novokhatskaia on 08/09/2022.
//

import Foundation

struct Launch: Codable, Identifiable {
    let flightNumber: Int
    let name: String
    let id: String
    let links: Links
}

struct Links: Codable {
    let patch: Patch
}

struct Patch: Codable {
    let small: String?
}
