//
//  MainView.swift
//  WeatherApp
//
//  Created by Yang W on 7/9/21.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var weatherVM = WeatherViewModel()
    
    var body: some View {
        
        VStack{
            Button(action: {
                
                weatherVM.tempUnit = "metric"
                weatherVM.cityIDs = "2158177,2147714"
                
                weatherVM.prepareWeatherDara(unit: weatherVM.tempUnit, cityIDs: weatherVM.cityIDs)
                
            }, label: {
                Text("get API")
            })
            
            if weatherVM.fetchDataStatus == .finishFetching {
                
                if weatherVM.fetchFail {
                    Text("Data not available, come back later")
                        .frame(maxHeight: .infinity)
                } else {
                    
                    List{
                        ForEach(weatherVM.weatherList, id: \.self){ weather in
                            
                            HStack{
                                Text("\(weather.cityName)")
                                
                                Spacer()
                                
                                Text("\(weather.temperature)")
                            }
                            .padding()
                        }
                    }
                    
                }
                
            } else if weatherVM.fetchDataStatus == .notFetching {
                Text("welcome")
                    .frame(maxHeight: .infinity)
            }
            else {
                ProgressView()
                    .frame(maxHeight: .infinity)
            }
        }
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}




