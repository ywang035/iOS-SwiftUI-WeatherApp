//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Yang W on 7/9/21.
//

import Foundation

class NetworkManager{
    
    
    
    func fetchAPIData(unit: String, cityIDs: String, completion:@escaping (APIResponse) -> ()) {
        
        print("fetching")
        
        let appID = "d36df9373c1eb937af289bc9b4685c80"
        
        guard let url = URL(string: "https://api.opeweathermap.org/data/2.5/group?id=\(cityIDs)&appid=\(appID)&units=\(unit)") else {
            print("Invalid url...")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
             
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodeResult = try! JSONDecoder().decode(APIResponse.self, from: data)
                        completion(decodeResult)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
}

