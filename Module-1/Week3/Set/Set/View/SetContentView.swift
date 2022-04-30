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
            
            HStack {
                Text("Set Game").font(.title).padding(.horizontal)
                
                Button("New Game") {
                    game.startNewGame()
                }
                .background(Color.blue)
                .foregroundColor(.white)
                .font(.title3)
            }
            
            VStack {
                AspectVGrid(items: game.cardsOnBoard, aspectRatio: 2/2, content: { card in
                    cardView(for: card)
                        .onTapGesture {
                            game.choose(card)
                        }
                }, isPileOrDeck: false)
            }
            //.padding()
            
            HStack(alignment: .center) {
                
                HStack(alignment: .center) {
                    
                    VStack {
                        Text("Deck").foregroundColor(.black)
                        AspectVGrid(items: game.deck, aspectRatio: 2/3, content: { card in
                            cardView(for: card)
                                .onTapGesture {
                                    withAnimation {
                                        if card.isOnDeck {
                                            game.deal()
                                        }
                                    }
                                }
                        }, isPileOrDeck: true)
                    }
                    VStack {
                        Text("DP")
                        if game.discardPileSize < 1 {
                            ZStack {
                                Text("☠️")
                                RoundedRectangle(cornerRadius: 15)
                                    .strokeBorder(lineWidth: 3)
                                    .foregroundColor(.black)
                                    .aspectRatio(2/3, contentMode: .fit)
                            }
                        }
                        else {
                                AspectVGrid(items: game.dPile, aspectRatio: 2/3, content: { card in
                                    cardView(for: card)
                                }, isPileOrDeck: true)
                        }
                    }
                }
                Text("Deck Size: \(game.deckSize)")  
                Text("DP Size: \(game.discardPileSize)")
            }
        }
    }
    
    @ViewBuilder
    func cardView(for card: SetGame<SetViewModel.CardContent>.Card) -> some View {
        Group {
            if let cardMatched = card.isMatched {
               if cardMatched {
                   CardView(card: card).cardModifier(.green, card.isOnDeck)
               } else {
                   CardView(card: card).cardModifier(.red, card.isOnDeck)
               }
           } else if card.isSelected {
               CardView(card: card).cardModifier(.blue, card.isOnDeck)
           } else {
               CardView(card: card).cardModifier(.black, card.isOnDeck)
           }
        }
        .padding(4)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
