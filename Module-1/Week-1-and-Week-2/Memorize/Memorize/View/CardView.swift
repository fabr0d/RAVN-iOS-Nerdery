//
//  CardView.swift
//  Memorize
//
//  Created by Fabrizio Flores on 19/04/22.
//

import SwiftUI

struct CardView: View {
    let card: Card<String>
    var linearGrad: Color
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            
            if card.isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else { //EC 3
                shape.fill(
                    LinearGradient(
                        gradient: Gradient(
                            colors: [linearGrad, Color.black]
                        ),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
    }
}
