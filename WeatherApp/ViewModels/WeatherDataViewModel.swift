//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Yang W on 7/9/21.
//

import Foundation

class WeatherDataViewModel: ObservableObject {
    
    @Published var weatherList = [Weather]()
    @Published var fetchDataStatus: FetchDataStatus = .notFetching
    @Published var fetchFail = false
    @Published var cityIDs: String = ""
    
    var selectedCityWeather: Weather?
    var selectedCityIndex: Int = -1
    
    var tempUnitCelsius: Bool = true
    var tempUnit: String = "metric"
    var cityIDList: [String] = [String]()
    
    var fetchDataTimer : Timer?
    var autoRefreshTimeInterval: Double = 1800
    
    enum FetchDataStatus: Identifiable {
        case  notFetching ,startFetching, finishFetching
        var id: Int {
            hashValue
        }
    }
    
    init(){
        // init city list
        self.cityIDList = isKeyPresentInUserDefaults(key: "SAVED_CITY_LIST") ? UserDefaults.standard.object(forKey: "SAVED_CITY_LIST") as! [String] : ["2158177", "2147714" ,"2174003"]
        self.cityIDs = self.cityIDList.joined(separator: ",")
        
        // init temp unit
        tempUnitCelsius = isKeyPresentInUserDefaults(key: "TEMP_UNIT") ? UserDefaults.standard.bool(forKey: "TEMP_UNIT") : true
        tempUnit = tempUnitCelsius ? "metric" : "imperial"
    }
    
    /// fetch data from API and append useful weather data
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
    
    
    /// save temp unit to user default when changed
    func saveTempUnit(){
        UserDefaults.standard.set(tempUnitCelsius, forKey: "TEMP_UNIT")
    }
    
    /// save city to user default when added / removed
    func saveCityList(){
        UserDefaults.standard.set(cityIDList, forKey: "SAVED_CITY_LIST")
    }
    
    /// check if userdefault exist
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
