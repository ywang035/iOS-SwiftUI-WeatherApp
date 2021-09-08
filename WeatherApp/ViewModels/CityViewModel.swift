//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Yang W on 7/9/21.
//

import Foundation

class CityViewModel: ObservableObject {
    var cityList = [City]()
    @Published var searchTerm = ""
    
//    init(){
//        cityList = loadTipData(jsonData: readLocalFile()!)
//    }
    
    func readLocalFile() -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: "city list",
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func loadTipData(jsonData: Data) -> [City]{
        var returnData = [City]()
        do {
            let decodedData = try JSONDecoder().decode([City].self, from: jsonData)
            returnData = decodedData
        } catch {
            print("decode error")
        }
        return returnData
    }
}
