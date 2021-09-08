//
//  DetailView.swift
//  WeatherApp
//
//  Created by Yang W on 7/9/21.
//

import SwiftUI

struct WeatherDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var weatherDataVM: WeatherDataViewModel
    
    var body: some View {
        VStack(spacing: 0){
            // header
            HeaderChildView(buttonFunction: {presentationMode.wrappedValue.dismiss()})
            
            ZStack{
                Color("gray").opacity(0.75)
                
                ScrollView(showsIndicators: false){
                    VStack{
                        
                        Text("\(weatherDataVM.selectedCityWeather?.cityName ?? "---"), \(weatherDataVM.selectedCityWeather?.countryName ?? "---")".uppercased())
                            .font(.title)
                            .bold()
                            .tracking(2)
                            .foregroundColor(Color("orange"))
                        
                        
                        VStack(spacing: 0){
                            Image("\(weatherDataVM.selectedCityWeather?.weatherIcon ?? "---")")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                            
                            Text("\(weatherDataVM.selectedCityWeather?.weatherDescription ?? "---")")
                                .bold()
                                .foregroundColor(Color("orange"))
                                .offset(y: -15)
                            
                            Text("\(weatherDataVM.selectedCityWeather?.temperature ?? 0.00, specifier: "%.2f") °\(weatherDataVM.tempUnitCelsius ? "C" : "F")")
                                .font(.system(size: 56))
                                .bold()
                                .foregroundColor(Color("orange"))
                        }
                        
                        VStack{
                            
                            WeatherDetailViewCard(cardName: "Temp Range", cardData: "\(weatherDataVM.selectedCityWeather?.tempMin ?? 0.00) ~ \(weatherDataVM.selectedCityWeather?.tempMax ?? 0.00) °\(weatherDataVM.tempUnitCelsius ? "C" : "F")")
                            
                            WeatherDetailViewCard(cardName: "Pressure", cardData: "\(weatherDataVM.selectedCityWeather?.pressure ?? 0)")
                            
                            WeatherDetailViewCard(cardName: "Humidity", cardData: "\(weatherDataVM.selectedCityWeather?.humidity ?? 0)")
                            
                            WeatherDetailViewCard(cardName: "Wind Speed", cardData: "\(weatherDataVM.selectedCityWeather?.windSpeed ?? 0)")
                            
                            WeatherDetailViewCard(cardName: "Wind Degree", cardData: "\(weatherDataVM.selectedCityWeather?.windDegree ?? 0)")
                            
                            WeatherDetailViewCard(cardName: "Visibility", cardData: "\(weatherDataVM.selectedCityWeather?.visibility ?? 0)")
                            
                        }
                    }
                    .padding()
                }

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .cornerRadius(8)
            .padding()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailView(weatherDataVM: WeatherDataViewModel())
    }
}


struct WeatherDetailViewCard: View {
    
    var cardName: String
    var cardData: String
    
    var body: some View {
        ZStack{
            Color("orange").opacity(0.8)
            
            HStack{
                Text(cardName)
                    .bold()
                Spacer()
                Text(cardData)
                    .bold()
            }
            .foregroundColor(Color("gray"))
            .padding(.horizontal)
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .cornerRadius(8)
    }
}
