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
            // MARK: - header
            HeaderView(weatherVM: weatherVM)
            
            // MARK: - main section
            if weatherVM.fetchDataStatus == .finishFetching {
                
                if weatherVM.fetchFail {
                    Text("Data not available.\nCome back later.")
                        .frame(maxHeight: .infinity)
                        .foregroundColor(Color("orange"))
                        .multilineTextAlignment(.center)
                } else {
                    
                    WeatherListView(weatherVM: weatherVM)
                    
                }
                
            } else if weatherVM.fetchDataStatus == .notFetching {
                Text("welcome")
                    .frame(maxHeight: .infinity)
            }
            else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color("orange")))
                    .scaleEffect(2)
                    .frame(maxHeight: .infinity)
            }
        }
        .onAppear(){
            weatherVM.tempUnit = "metric"
            weatherVM.cityIDs = "2158177,2147714,2174003"

            weatherVM.prepareWeatherDara(unit: weatherVM.tempUnit, cityIDs: weatherVM.cityIDs)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}




