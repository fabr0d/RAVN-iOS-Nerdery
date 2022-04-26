//
//  CardView.swift
//  Memorize
//
//  Created by Fabrizio Flores on 19/04/22.
//

import SwiftUI

struct CardView: View {
    private let card: EmojiMemoryGame.vmCard
    var linearGrad: Color
    
    init(_ card: EmojiMemoryGame.vmCard, _ linearGrad: Color) {
        self.card = card
        self.linearGrad = linearGrad
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)

                if card.isFaceUp {
                    shape.fill(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidht)

                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
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
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidht: CGFloat = 3
        static let fontScale: CGFloat = 0.75
    }
}
