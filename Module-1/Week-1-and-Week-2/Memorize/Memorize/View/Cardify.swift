//
//  Cardify.swift
//  Memorize
//
//  Created by Fabrizio Flores on 27/04/22.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    var gradColor: Color
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)

            if isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidht)
            } else {
                shape.fill(
                    LinearGradient(
                        gradient: Gradient(
                            colors: [gradColor, Color.black]
                        ),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            content
                .opacity(isFaceUp ? 1 : 0)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidht: CGFloat = 3
        
    }
}

extension View {
    func cardify(isFaceUp: Bool, gradColor: Color) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, gradColor: gradColor))
    }
}
