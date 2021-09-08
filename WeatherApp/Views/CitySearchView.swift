//
//  SearchView.swift
//  WeatherApp
//
//  Created by Yang W on 7/9/21.
//

import SwiftUI

struct CitySearchView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var weatherDataVM: WeatherDataViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        CitySearchView(weatherDataVM: WeatherDataViewModel())
    }
}
