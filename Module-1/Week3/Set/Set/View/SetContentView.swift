//
//  ContentView.swift
//  Set
//
//  Created by Fabrizio Flores on 21/04/22.
//

import SwiftUI

struct SetContentView: View {
    @ObservedObject var game = SetViewModel()
    
    var body: some View {
        VStack {
            VStack {
                AspectVGrid(items: game.cardsOnBoard, aspectRatio: 2/3, content: { card in
                    cardView(for: card)
                        .onTapGesture {
                            game.choose(card)
                        }
                })
            }
            Spacer()
            
            HStack(alignment: .center) {
                Button("New Game") {
                    game.startNewGame()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .font(.title3)
                
                if !game.deck.isEmpty {
                    Button("+3") {
                        game.deal()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .font(.title3)
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    func cardView(for card: SetGame<SetViewModel.CardContent>.Card) -> some View {
        Group {
            if let cardMatched = card.isMatched {
               if cardMatched {
                   CardView(card: card).cardModifier(.green)
               } else {
                   CardView(card: card).cardModifier(.red)
               }
           } else if card.isSelected {
               CardView(card: card).cardModifier(.blue)
           } else {
               CardView(card: card).cardModifier(.black)
           }
        }
        .padding(4)
    }
}

struct CardModifier: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        ZStack {
            let cardShape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            cardShape
                .fill()
                .foregroundColor(.white)
            cardShape
                .strokeBorder(lineWidth: DrawingConstants.lineWidth)
                .foregroundColor(color)
            content
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 15
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardModifier(_ color: Color) -> some View {
        self.modifier(CardModifier(color: color))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
