//
//  Weather.swift
//  WeatherApp
//
//  Created by Yang W on 7/9/21.
//

import Foundation


/// weather data (sorted from meta data)
struct Weather: Codable {
    var weatherDescription: String
    var temperature: Double
    var tempMin: Double
    var tempMax: Double
    var weatherIcon: String
    var pressure: Int
    var humidity: Int
    var windSpeed: Double
    var windDegree: Int
    var visibility: Int
    var cityName: String
    var countryName: String
}
