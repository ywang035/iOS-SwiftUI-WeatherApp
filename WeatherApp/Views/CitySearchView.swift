//
//  SearchView.swift
//  WeatherApp
//
//  Created by Yang W on 7/9/21.
//

import SwiftUI
//import SQLite

struct CitySearchView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var weatherDataVM: WeatherDataViewModel
    @ObservedObject var cityVM = CityViewModel()
    
    @State var searchTerm = ""
    @State var loading = false
    
    var body: some View {
        VStack(spacing: 0){
            
            HeaderChildView(buttonFunction: {presentationMode.wrappedValue.dismiss()})
            
            VStack{
                // search box and button
                HStack(spacing: 15){
                    TextField("Enter City", text: $searchTerm)
                        .padding(.horizontal)
                        .frame(height: 40)
                        .background(RoundedRectangle(cornerRadius: 20).stroke(Color("orange"), lineWidth: 1.5))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    
                    Text("Search")
                        .bold()
                        .padding()
                        .frame(height: 40)
                        .foregroundColor(Color.white)
                        .background(Color("orange"))
                        .cornerRadius(25)
                        .onTapGesture {
                            loading = true
                            cityVM.searchCity(searchTerm: searchTerm, completion: { results in
                                
                                cityVM.citySearchResult = results
                                
                                DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                                    loading = false
                                })
                                
                            })
                        }
                }
                .padding(.horizontal)
                
                if loading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color("orange")))
                        .scaleEffect(1.5)
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding()
                } else {
                    ScrollView{
                        LazyVStack{
                            ForEach(cityVM.citySearchResult, id: \.self){ city in
                                Text("\(city.name), \(city.country)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                            }
                        }
                    }
                    .padding()
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        CitySearchView(weatherDataVM: WeatherDataViewModel())
    }
}
