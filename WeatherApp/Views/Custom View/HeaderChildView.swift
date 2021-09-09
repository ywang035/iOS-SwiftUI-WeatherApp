//
//  HeaderChildView.swift
//  WeatherApp
//
//  Created by Yang W on 8/9/21.
//

import SwiftUI

struct HeaderChildView: View {
    
    var leadingButtonFunction = {}
    
    var showtrailingButton: Bool
    var trailingButtonFunction = {}
    var cityIndex: Int?
    
    var body: some View {
        HStack {
            
            Button(action: {
                leadingButtonFunction()
            }, label: {
                HStack{
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
            })
            
            Spacer()
            
            if showtrailingButton {
                Button(action: {
                    trailingButtonFunction()
                }, label: {
                    Image(systemName: "trash.circle")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 25)
                        .foregroundColor(Color("orange"))
                })
            }
        }
        .frame(height: 50)
        .foregroundColor(Color("orange"))
        .padding(.horizontal)
    }
}

//struct HeaderChildView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeaderChildView()
//    }
//}
