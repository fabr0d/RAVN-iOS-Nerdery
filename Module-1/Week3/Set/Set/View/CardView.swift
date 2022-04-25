//
//  CardView.swift
//  Set
//
//  Created by Fabrizio Flores on 25/04/22.
//

import SwiftUI

struct CardView: View {
    let card: SetGame<RegularSetGame.CardContent>.Card
    
    var body: some View {
        VStack {
            ForEach(0..<card.content.number, id: \.self) { _ in
                
                switch card.content.shape {
                    
                case .circle:
                    switch card.content.shading {
                        case .solid:
                            Circle()
                                .fill()
                        case .striped:
                            Circle()
                                .opacity(DrawingConstants.opacity)
                        case .open:
                            Circle()
                                .strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    }
                    
                case .diamond:
                    switch card.content.shading {
                        case .solid: //to do
                        case .striped: //to do
                        case .open: //to do
                        
                    }
                    
                case .rectangle:
                    switch card.content.shading {
                    case .solid: //to do
                    case .striped: //to do
                    case .open: //to do
                    }
                }
            }
            .aspectRatio(2/1, contentMode: .fit)
            .foregroundColor(RegularSetGame.selectColor(for: card))
        }
        .padding(DrawingConstants.padding)
    }
    
    private struct DrawingConstants {
        static let opacity: Double = 0.7
        static let lineWidth: CGFloat = 2
        static let padding: CGFloat = 5
    }
}

struct CardView_Previews: PreviewProvider {
    
    static var previews: some View {
        let game = RegularSetGame()
        CardView(card: game.deck[1])
    }
}
