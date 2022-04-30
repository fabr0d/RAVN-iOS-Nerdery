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
            gameHeader
            gameBody
            gameFooter
        }
        .padding()
    }
    
    var gameHeader: some View {
        HStack {
            Text("Memorize!")
                .padding(.all)
                .font(.largeTitle)
            
            Text("Score: \(game.getScore)")
                .padding(.all)
        }
    }
    
    var gameBody: some View {
        ScrollView {
            Text(game.themeName)
            
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                if card.isMatched && !card.isFaceUp {
                    Color.clear
                } else {
                    CardView(card, game.getColorCard)
                        .padding(3)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
            .padding(.horizontal)
        }
    }
    
    var gameFooter: some View {
        HStack {
            Button {
                game.newGame()
            } label: {
                Text("New Game").font(.title)
            }
            
            Button("Shuffle"){
                withAnimation {
                    game.shuffle()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
    }
}
