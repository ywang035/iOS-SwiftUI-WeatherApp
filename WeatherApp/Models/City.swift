//
//  City.swift
//  WeatherApp
//
//  Created by Yang W on 7/9/21.
//

import Foundation

struct City: Codable, Hashable {
    var id: Int
    var name: String
    var state: String
    var country: String
    var coord: CityCoordinator?
}


struct CityCoordinator: Codable, Hashable {
    var lon: Double?
    var lat: Double?
}
