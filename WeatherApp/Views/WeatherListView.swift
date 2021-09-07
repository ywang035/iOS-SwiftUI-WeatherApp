//
//  WeatherListView.swift
//  WeatherApp
//
//  Created by Yang W on 7/9/21.
//

import SwiftUI

struct WeatherListView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    
    var body: some View {
        
        ScrollView{
            VStack{
                ForEach(weatherVM.weatherList, id: \.self){ weather in
                    WeatherCardView(weather: weather)
                }
            }
        }
        
    }
}

struct WeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListView(weatherVM: WeatherViewModel())
    }
}
