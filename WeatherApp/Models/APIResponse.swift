//
//  APIResponse.swift
//  WeatherApp
//
//  Created by Yang W on 7/9/21.
//

import Foundation

/// api response
struct APIResponse: Codable {
    var cnt: Int
    var list: [DataList]
}

/// meta data list
struct DataList: Codable {
    var coord: Coordinator
    var sys: SysInfo
    var weather: [MinorWeather]
    var main: MainWeather
    var visibility: Int
    var wind: Wind
    var clouds: Cloud
    var dt, id: Int
    var name: String
    
}


/// meta data main weather
struct MainWeather: Codable {
    var temp, feels_like, temp_min, temp_max: Double
    var pressure, humidity: Int
}


/// meta data minor weather
struct MinorWeather: Codable {
    var id: Int
    var main, description, icon: String
}

/// meta data wind
struct Wind: Codable {
    var speed: Double
    var deg: Int
}

/// meta data cloud
struct Cloud: Codable {
    var all: Int
}

/// meta data system info( time zone, sun info)
struct SysInfo: Codable {
    var country: String
    var timezone, sunrise, sunset: Int
}

/// meta data coordinator
struct Coordinator: Codable {
    var lon, lat: Double
}
