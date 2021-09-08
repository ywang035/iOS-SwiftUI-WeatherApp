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
    @State var searchLoading = false
    @State var searchAddAlert = false
    
    var body: some View {
        VStack(spacing: 0){
            
            HeaderChildView(buttonFunction: {presentationMode.wrappedValue.dismiss()})
            
            ZStack{
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
                                searchLoading = true
                                cityVM.searchCity(searchTerm: searchTerm, completion: { results in
                                    cityVM.citySearchResult = results
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                                        searchLoading = false
                                    })
                                })
                            }
                    }
                    .padding(.horizontal)
                    
                    
                    // main search result list
                    if searchLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color("orange")))
                            .scaleEffect(1.5)
                            .frame(maxHeight: .infinity, alignment: .top)
                            .padding()
                    } else {
                        ScrollView{
                            LazyVStack{
                                ForEach(cityVM.citySearchResult, id: \.self){ city in
                                    HStack{
                                        Text("\(city.name), \(city.country)")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding()
                                        Spacer()
                                        Button(action: {
                                            withAnimation{ searchAddAlert = true }
                                            
                                            weatherDataVM.cityIDs += ",\(city.id)"
                                            searchTerm = ""
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                                                withAnimation{ searchAddAlert = false }
                                            })
                                        }, label: {
                                            Image(systemName: "plus.circle")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(Color("orange"))
                                                .padding(5)
                                        })
                                    }
                                    .frame(height: 40)
                                    .padding(.horizontal)
                                }
                            }
                        }
                        .padding()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                
                if searchAddAlert {
                    VStack{
                        Text("City Added")
                            .bold()
                            .padding()
                            .frame(height: 40)
                            .foregroundColor(Color.white)
                            .background(Color("orange"))
                            .cornerRadius(25)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                }
            }
            

        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        CitySearchView(weatherDataVM: WeatherDataViewModel())
    }
}
