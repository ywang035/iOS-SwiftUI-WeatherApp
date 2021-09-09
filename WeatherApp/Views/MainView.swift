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
                Text("Add Cities")
                    .frame(maxHeight: .infinity)
                    .foregroundColor(Color("orange"))
            }
        }
        .onReceive(weatherDataVM.$cityIDs, perform: { _ in
            if weatherDataVM.cityIDs.count > 0{
                weatherDataVM.prepareWeatherDara(unit: weatherDataVM.tempUnit, cityIDs: weatherDataVM.cityIDs)
            } else {
                weatherDataVM.fetchDataStatus = .notFetching
            }
        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}




