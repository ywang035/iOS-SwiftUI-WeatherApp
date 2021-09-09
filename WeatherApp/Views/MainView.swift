//
//  MainView.swift
//  WeatherApp
//
//  Created by Yang W on 7/9/21.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.scenePhase) var scenePhase
    
    @ObservedObject var weatherDataVM = WeatherDataViewModel()
    
    @State var autoRefreshTimer: Timer?
    
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
                Text("Add a city to see weather")
                    .frame(maxHeight: .infinity)
                    .foregroundColor(Color("orange"))
            }
        }
        .onReceive(weatherDataVM.$cityIDs, perform: { _ in  // auto fetch weather data when city list changed
            if weatherDataVM.cityIDs.count > 0{
                weatherDataVM.prepareWeatherDara(unit: weatherDataVM.tempUnit, cityIDs: weatherDataVM.cityIDs)
            } else {
                weatherDataVM.fetchDataStatus = .notFetching
            }
        })
        .onAppear(){    // timer to refresh weather
            autoRefreshTimer = Timer.scheduledTimer(withTimeInterval: weatherDataVM.autoRefreshTimeInterval, repeats: true) { timer in
                if weatherDataVM.cityIDs.count > 0{
                    weatherDataVM.prepareWeatherDara(unit: weatherDataVM.tempUnit, cityIDs: weatherDataVM.cityIDs)
                } else {
                    weatherDataVM.fetchDataStatus = .notFetching
                }
            }
        }
        .onChange(of: scenePhase) { newPhase in // auto refresh when come back to foreground
            if newPhase == .active {
                if weatherDataVM.cityIDs.count > 0{
                    weatherDataVM.prepareWeatherDara(unit: weatherDataVM.tempUnit, cityIDs: weatherDataVM.cityIDs)
                } else {
                    weatherDataVM.fetchDataStatus = .notFetching
                }
                
                autoRefreshTimer = Timer.scheduledTimer(withTimeInterval: weatherDataVM.autoRefreshTimeInterval, repeats: true) { timer in
                    if weatherDataVM.cityIDs.count > 0{
                        weatherDataVM.prepareWeatherDara(unit: weatherDataVM.tempUnit, cityIDs: weatherDataVM.cityIDs)
                    } else {
                        weatherDataVM.fetchDataStatus = .notFetching
                    }
                }
                
            } else if newPhase == .inactive {
                autoRefreshTimer?.invalidate()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}




