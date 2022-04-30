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
        GeometryReader { geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                    .fill(linearGrad)
                    .opacity(0.5)
                    .padding(5)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    //.animation(Animation.easeInOut(duration: 2))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    //.font(font(in: geometry.size))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp, gradColor: linearGrad)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
//    private func font(in size: CGSize) -> Font {
//        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
//    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
        
    }
}
