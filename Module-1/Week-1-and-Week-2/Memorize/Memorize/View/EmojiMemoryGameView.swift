//
//  ContentView.swift
//  Memorize
//
//  Created by Fabrizio Flores on 5/04/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            HStack {
                Text("Memorize!")
                    .padding(.all)
                    .font(.largeTitle)
                
                Text("Score: \(game.getScore)")
                    .padding(.all)
            }
            
            ScrollView {
                Text(game.themeName)
                
                AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                    if card.isMatched && !card.isFaceUp {
                        Rectangle().opacity(0)
                    } else {
                        CardView(card, game.getColorCard)
                            .padding(4)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
            }
            
            HStack {
                Button {
                    game.newGame()
                } label: {
                    Text("New Game")
                }
            }
            .font(.title)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        Group {
            EmojiMemoryGameView(game: game)
                .preferredColorScheme(.light)
            EmojiMemoryGameView(game: game)
                .preferredColorScheme(.dark)
        }
    }
}
