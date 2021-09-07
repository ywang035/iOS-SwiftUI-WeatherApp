//
//  HeaderView.swift
//  WeatherApp
//
//  Created by Yang W on 7/9/21.
//

import SwiftUI

struct HeaderView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    
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
                    weatherVM.tempUnit = "metric"
                    weatherVM.cityIDs = "2174003"

                    weatherVM.prepareWeatherDara(unit: weatherVM.tempUnit, cityIDs: weatherVM.cityIDs)
                }, label: {
                    Image(systemName: "goforward")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 25)
                        .foregroundColor(Color("orange"))
                })
                .padding(10)
                    
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "plus.magnifyingglass")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 25)
                        .foregroundColor(Color("orange"))
                })
                .padding(10)
                
                    
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
        HeaderView(weatherVM: WeatherViewModel())
    }
}
