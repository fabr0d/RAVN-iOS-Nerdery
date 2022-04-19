//
//  ContentView.swift
//  Memorize
//
//  Created by Fabrizio Flores on 5/04/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            HStack {
                Text("Memorize!") //2
                    .padding(.all)
                    .font(.largeTitle)
                
                Text("Score: \(viewModel.getScore)")
                    .padding(.all)
            }
            
            ScrollView {
                Text(viewModel.themeName) //14
                
                LazyVGrid(
                    columns: [
                        GridItem(
                            .adaptive(
                                minimum:
                                    HelpFunctions.widthThatBestFits(cardCount: viewModel.cards.count)
                            )
                        )
                    ]
                )   {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card, linearGrad: viewModel.getColorCard)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            
            HStack {
                Button { //10
                    viewModel.newGame() //11
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
            ContentView(viewModel: game)
                .preferredColorScheme(.light)
            ContentView(viewModel: game)
                .preferredColorScheme(.dark)
        }
    }
}
