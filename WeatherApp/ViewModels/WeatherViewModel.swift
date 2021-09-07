//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Yang W on 7/9/21.
//

import Foundation

class WeatherViewModel: ObservableObject {
    
    @Published var weatherList = [Weather]()
    @Published var fetchDataStatus: FetchDataStatus = .notFetching
    @Published var fetchFail = false
    
    var tempUnit: String = "metric"
    var cityIDs: String = ""
    
    var fetchDataTimer : Timer?
    
    enum FetchDataStatus: Identifiable {
        case  notFetching ,startFetching, finishFetching
        var id: Int {
            hashValue
        }
    }
    
    func prepareWeatherDara(unit: String, cityIDs: String) {
        
        self.fetchDataStatus = .startFetching
        
        NetworkManager().fetchAPIData(unit: unit, cityIDs: cityIDs, completion: { [self] response in
            
            self.weatherList.removeAll()
            
            for metaData in response.list {
                let cleanWeatherData = Weather(weatherDescription: metaData.weather[0].description, weatherIcon: metaData.weather[0].icon, temperature: metaData.main.temp, tempMin: metaData.main.temp_min, tempMax: metaData.main.temp_max, pressure: metaData.main.pressure, humidity: metaData.main.humidity, windSpeed: metaData.wind.speed, windDegree: metaData.wind.deg, visibility: metaData.visibility, cityName: metaData.name, countryName: metaData.sys.country)
                
                self.weatherList.append(cleanWeatherData)
            }
            
            self.fetchDataStatus = .finishFetching
            self.fetchFail = false
            fetchDataTimer?.invalidate()
            
        })
        
        fetchDataTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { timer in
            if self.weatherList.count == 0 {
                self.fetchDataStatus = .finishFetching
                self.fetchFail = true
            } else {
                self.fetchDataStatus = .finishFetching
                self.fetchFail = false
            }
//            print("fetch fail from timer: \(self.fetchFail)")
        }
    }
    
}
