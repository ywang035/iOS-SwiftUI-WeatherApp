//
//  WeatherCardView.swift
//  WeatherApp
//
//  Created by Yang W on 7/9/21.
//

import SwiftUI

struct WeatherCardView: View {
    
    var weather: Weather
    
    var body: some View {
        
        ZStack{
            
            Color("gray").opacity(0.75)
            
            HStack{
                Text("\(weather.cityName)")
                    .bold()
                    .foregroundColor(Color("orange"))
                
                Spacer()
                
                Image("\(weather.weatherIcon)")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                
                Text("\(weather.temperature, specifier: "%.2f")°C")
                    .foregroundColor(Color("orange"))
                
                Image(systemName: "chevron.right")

            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 75)
        .cornerRadius(8)
        .padding(.horizontal)
        
    }
}

struct WeatherCardView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherCardView(weather: Weather(weatherDescription: "Sun", weatherIcon: "01d", temperature: 20.5, tempMin: 10.5, tempMax: 30.5, pressure: 100, humidity: 200, windSpeed: 30, windDegree: 45, visibility: 1000, cityName: "Melbourne", countryName: "AU"))
    }
}
