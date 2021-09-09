//
//  WeatherDetailViewCard.swift
//  WeatherApp
//
//  Created by Yang W on 9/9/21.
//

import SwiftUI

struct WeatherDetailViewCard: View {
    
    var cardName: String
    var cardData: String
    
    var body: some View {
        ZStack{
            Color("orange").opacity(0.8)
            
            HStack{
                Text(cardName)
                    .bold()
                Spacer()
                Text(cardData)
                    .bold()
            }
            .foregroundColor(Color("gray"))
            .padding(.horizontal)
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .cornerRadius(8)
    }
}
