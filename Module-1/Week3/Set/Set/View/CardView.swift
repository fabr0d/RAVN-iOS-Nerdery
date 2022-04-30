//
//  CardView.swift
//  Set
//
//  Created by Fabrizio Flores on 25/04/22.
//

import SwiftUI

struct CardView: View {
    let card: SetGame<SetViewModel.CardContent>.Card
    
    var body: some View {
        VStack {
            //number of items in a card
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
                            case .solid:
                                Diamond()
                                    .fill()
                            case .striped:
                                Diamond()
                                    .opacity(DrawingConstants.opacity)
                            case .open:
                                Diamond()
                                    .stroke(lineWidth: DrawingConstants.lineWidth)
                            
                        }
                    case .rectangle:
                        switch card.content.shading {
                            case .solid:
                                Rectangle()
                                    .fill()
                            case .striped:
                                Rectangle()
                                    .opacity(DrawingConstants.opacity)
                            case .open:
                                Rectangle()
                                    .strokeBorder(lineWidth: DrawingConstants.lineWidth)
                        }
                }
            }
            .aspectRatio(2/1, contentMode: .fit)
            .foregroundColor(SetViewModel.selectColor(for: card))
            .padding(DrawingConstants.padding)
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
        let game = SetViewModel()
        CardView(card: game.deck[Int.random(in: 0...game.deck.count)])
    }
}
