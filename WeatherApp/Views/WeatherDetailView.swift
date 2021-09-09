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
    
    @State var showWeatherDetail = false
    @State var showDeleteCityAlert = false
    @State var deleteCityConfirmed = false
    
    var body: some View {
        VStack(spacing: 0){
            // header
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack{
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                })
                
                Spacer()
                
                Button(action: {
                    showDeleteCityAlert = true
                }, label: {
                    Image(systemName: "trash.circle")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 25)
                        .foregroundColor(Color("orange"))
                })
            }
            .frame(height: 50)
            .foregroundColor(Color("orange"))
            .padding(.horizontal)
            .alert(isPresented: $showDeleteCityAlert, content: {
                Alert(
                    title: Text("Remove this city?"),
                    message: Text("You can add this city back later."),
                    primaryButton: .destructive(Text("Delete")) {
                        deleteCityConfirmed = true
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()
                )
            })
            
            
                ZStack{
                    Color("gray").opacity(0.75)
                    
                    if showWeatherDetail {
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
                                    .shadow(color: Color("orange"), radius: 15)
                                
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
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(8)
                .padding()
            
        }
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                withAnimation { showWeatherDetail = true }
            })
        }
        .onDisappear(){
            if deleteCityConfirmed {
                weatherDataVM.cityIDList.remove(at: weatherDataVM.selectedCityIndex)
                weatherDataVM.cityIDs = weatherDataVM.cityIDList.joined(separator: ",")
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailView(weatherDataVM: WeatherDataViewModel())
    }
}


