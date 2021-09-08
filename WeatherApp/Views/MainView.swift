//
//  MainView.swift
//  WeatherApp
//
//  Created by Yang W on 7/9/21.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var weatherDataVM = WeatherDataViewModel()
    
    var body: some View {
        
        VStack{
            // MARK: - header
            HeaderMainView(weatherDataVM: weatherDataVM)
            
            // MARK: - main section
            switch weatherDataVM.fetchDataStatus {
            
            case .finishFetching:
                if weatherDataVM.fetchFail {
                    Text("Data not available.\nCome back later.")
                        .frame(maxHeight: .infinity)
                        .foregroundColor(Color("orange"))
                        .multilineTextAlignment(.center)
                } else {
                    WeatherListView(weatherDataVM: weatherDataVM)
                }
                
            case .startFetching:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color("orange")))
                    .scaleEffect(2)
                    .frame(maxHeight: .infinity)
                
            case .notFetching:
                Text("welcome")
                    .frame(maxHeight: .infinity)
            }
        }
        .onAppear(){
            weatherDataVM.tempUnit = "metric"
            weatherDataVM.cityIDs = "2158177,2147714,2174003"
            
            weatherDataVM.prepareWeatherDara(unit: weatherDataVM.tempUnit, cityIDs: weatherDataVM.cityIDs)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}




