//
//  CardModifier.swift
//  Set
//
//  Created by Fabrizio Flores on 28/04/22.
//

import SwiftUI

struct CardModifier: ViewModifier {
    let color: Color
    var isOnDeck: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let cardShape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if !isOnDeck {
                cardShape
                    .fill()
                    .foregroundColor(.white)
                cardShape
                    .strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    .foregroundColor(color)
                content
            } else {
                cardShape
                    .fill()
                    .foregroundColor(.black)
                cardShape
                    .strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    .foregroundColor(color)
            }
            
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 15
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardModifier(_ color: Color, _ isOnDeck: Bool) -> some View {
        self.modifier(CardModifier(color: color, isOnDeck: isOnDeck))
    }
}
