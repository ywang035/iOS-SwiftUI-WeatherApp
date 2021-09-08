//
//  HeaderChildView.swift
//  WeatherApp
//
//  Created by Yang W on 8/9/21.
//

import SwiftUI

struct HeaderChildView: View {
    
    var buttonFunction = {}
    
    var body: some View {
        HStack {
            HStack{
                Image(systemName: "chevron.left")
                Text("Back")
            }
            .onTapGesture {
                buttonFunction()
            }
            
            Spacer()
        }
        .frame(height: 50)
        .foregroundColor(Color("orange"))
        .padding(.horizontal)
    }
}

struct HeaderChildView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderChildView()
    }
}
