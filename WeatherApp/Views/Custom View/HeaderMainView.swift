//
//  HeaderView.swift
//  WeatherApp
//
//  Created by Yang W on 7/9/21.
//

import SwiftUI

struct HeaderMainView: View {
    
    @ObservedObject var weatherDataVM: WeatherDataViewModel
    
    @State var showSearchView = false
    
    var body: some View {
        VStack(spacing: 0){
            // MARK: - header
            HStack{
                Text("Weather".uppercased())
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("orange"))
                    
                Spacer()
                
                Button(action: {
                    weatherDataVM.tempUnitCelsius.toggle()
                    weatherDataVM.tempUnit = weatherDataVM.tempUnitCelsius ? "metric" : "imperial"
                    weatherDataVM.saveTempUnit()
                    
                    weatherDataVM.prepareWeatherDara(unit: weatherDataVM.tempUnit, cityIDs: weatherDataVM.cityIDs)
                }, label: {
                    HStack(spacing:0){
                        Text("F")
                            .foregroundColor(weatherDataVM.tempUnitCelsius ? Color.gray : Color("orange"))
                            
                        Text("/")
                            .foregroundColor(Color.gray)
                        
                        Text("C")
                            .foregroundColor(weatherDataVM.tempUnitCelsius ? Color("orange") : Color.gray)
                    }
                    .font(.system(size: 26))
                    .frame(height: 25)
                })
                .padding(10)
                
                
                Button(action: {
                    weatherDataVM.tempUnit = weatherDataVM.tempUnitCelsius ? "metric" : "imperial"

                    weatherDataVM.prepareWeatherDara(unit: weatherDataVM.tempUnit, cityIDs: weatherDataVM.cityIDs)
                }, label: {
                    Image(systemName: "goforward")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 25)
                        .foregroundColor(Color("orange"))
                })
                .padding(10)
                    
                Button(action: {
                    showSearchView = true
                }, label: {
                    Image(systemName: "plus.magnifyingglass")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 25)
                        .foregroundColor(Color("orange"))
                })
                .padding(10)
                .fullScreenCover(isPresented: $showSearchView, content: {
                    CitySearchView(weatherDataVM: weatherDataVM)
                })
            }
            .frame(height: 50)
            .padding()
            
            Rectangle()
                .frame(height: 1)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color("orange").opacity(0.75))
                .padding([.horizontal, .bottom])
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderMainView(weatherDataVM: WeatherDataViewModel())
    }
}
