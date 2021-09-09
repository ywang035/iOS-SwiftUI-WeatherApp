//
//  CityDataViewModel.swift
//  WeatherApp
//
//  Created by Yang W on 7/9/21.
//

import Foundation
import SQLite


class CityDataViewModel: ObservableObject {
    
    @Published var citySearchResult = [City]()
    
    var cityList = [City]()
    var cityListDB: Connection!
    var cityListDBCount = 0
    
    init(){
        do {
            let path = Bundle.main.path(forResource: "cityList", ofType: "sqlite3")!
            self.cityListDB = try Connection(path, readonly: true)
        } catch {
            print("error")
        }
        
    }

    
    /// read city list.json file
//    func readLocalFile() -> Data? {
//        do {
//            if let bundlePath = Bundle.main.path(forResource: "city list",
//                                                 ofType: "json"),
//               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
//                return jsonData
//            }
//        } catch {
//            print(error)
//        }
//        return nil
//    }
    
    
    /// read city data from json
//    func loadCityData(jsonData: Data) -> [City]{
//        var returnData = [City]()
//        do {
//            let decodedData = try JSONDecoder().decode([City].self, from: jsonData)
//            returnData = decodedData
//        } catch {
//            print("decode error")
//        }
//        return returnData
//    }
    
    
    /// write city json data to sqlite db
//    func importCityDataToSQLite() {
//        print("start loading")
//        do {
//            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
//
//            // creating database connection
//            cityListDB = try Connection("\(path)/cityList.sqlite3")
//
//            let citys = Table("Citys")
//            let id = Expression<Int>("rowID")
//            let name = Expression<String?>("name")
//            let state = Expression<String>("state")
//            let country = Expression<String>("country")
//            let cityID = Expression<Int>("id")
//
//            try cityListDB.run(citys.create { t in
//                t.column(id, primaryKey: true)
//                t.column(name)
//                t.column(state)
//                t.column(country)
//                t.column(cityID)
//            })
//
//            for city in cityList {
//                let insert = citys.insert(name <- city.name, state <- city.state, country <- city.country, cityID <- city.id)
//                _ = try cityListDB.run(insert)
//            }
//
//            cityListDBCount = (try cityListDB.scalar(citys.count))
//
//        } catch {
//            print (error)
//        }
//    }
    
    
    /// return count of default table
//    func getTableRowCount() -> Int{
//        var result = 0
//        do {
//            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
//
//            cityListDB = try Connection("\(path)/cityList.sqlite3")
//
//            let citys = Table("Citys")
//            result = try cityListDB.scalar(citys.count)
//
//        } catch {
//            print (error)
//        }
//
//        return result
//    }
    
    
    
    /// return search result from db
    func searchCity(searchTerm: String, completion:@escaping ([City]) -> ()) {
        DispatchQueue.main.async {
            self.citySearchResult.removeAll()
            var results = [City]()

            do {
                let citys = Table("Citys")
                let name = Expression<String?>("name")
//                let state = Expression<String>("state")
                let country = Expression<String>("country")
                let cityID = Expression<Int>("id")


                for cityRow in try self.cityListDB.prepare(citys) {
                    do {

                        let cityName = try cityRow.get(name)?.lowercased() ?? ""

                        if  cityName.contains(searchTerm) {

                            let cityName = (try cityRow.get(name))!
//                            let cityState = try cityRow.get(state)
                            let cityCountry = try cityRow.get(country)
                            let cityID = try cityRow.get(cityID)

                            let city = City(id: cityID, name: cityName, state: "", country: cityCountry)

                            results.append(city)
                        }
                    } catch {
                        // handle
                        print("fail to query)")
                    }
                }

                completion(results)

            } catch {
                print (error)
            }
        }
        
    }    
}
