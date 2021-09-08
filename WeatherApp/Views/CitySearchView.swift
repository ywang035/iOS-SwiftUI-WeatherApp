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
    
    @ObservedObject var cityVM = CityViewModel()
    
    var body: some View {
        VStack(spacing: 0){
            
            HeaderChildView(buttonFunction: {presentationMode.wrappedValue.dismiss()})
            
            VStack{
                
                
                
            }
        }
        .onAppear(){
            DispatchQueue.global(qos: .userInteractive).async {
                cityVM.cityList = cityVM.loadTipData(jsonData: cityVM.readLocalFile()!)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        CitySearchView(weatherDataVM: WeatherDataViewModel())
    }
}
