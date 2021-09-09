//
//  WeatherListView.swift
//  WeatherApp
//
//  Created by Yang W on 7/9/21.
//

import SwiftUI

struct WeatherListView: View {
    
    @ObservedObject var weatherDataVM: WeatherDataViewModel
    
    @State var showWeatherDetail = false
    
    var body: some View {
        
        ScrollView{
            VStack{
                ForEach(Array(zip(weatherDataVM.weatherList, weatherDataVM.weatherList.indices)), id: \.0){ cityWeather, index in
                    WeatherListCardView(weatherDataVM: weatherDataVM, weather: cityWeather)
                        .onTapGesture {
                            showWeatherDetail = true
                            weatherDataVM.selectedCityWeather = cityWeather
                            weatherDataVM.selectedCityIndex = index
                        }
                        .fullScreenCover(isPresented: $showWeatherDetail, content: {
                            WeatherDetailView(weatherDataVM: weatherDataVM)
                        })
                }
            }
        }

    }
}

struct WeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListView(weatherDataVM: WeatherDataViewModel())
    }
}
