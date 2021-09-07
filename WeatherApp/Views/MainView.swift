//
//  MainView.swift
//  WeatherApp
//
//  Created by Yang W on 7/9/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        
        VStack{
            Button(action: {
                APICaller().loadData { value in
                    print(value)
                }
            }, label: {
                Text("get API")
            })
        }
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}





class APICaller : ObservableObject{
    
    func loadData(completion:@escaping (AIPResponse) -> ()) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/group?id=2158177,2147714&appid=d36df9373c1eb937af289bc9b4685c80") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let decodeResult = try! JSONDecoder().decode(AIPResponse.self, from: data!)
                        DispatchQueue.main.async {
                            completion(decodeResult)
                        }
        }.resume()
        
    }
}
