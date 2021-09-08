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
                ForEach(weatherDataVM.weatherList, id: \.self){ cityWeather in
                    WeatherCardView(weatherDataVM: weatherDataVM, weather: cityWeather)
                        .onTapGesture {
                            showWeatherDetail = true
                            weatherDataVM.selectedCityWeather = cityWeather
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
