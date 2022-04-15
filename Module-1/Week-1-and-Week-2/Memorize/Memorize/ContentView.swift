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
                ) {
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

struct CardView: View {
    let card: MemoryGame<String>.Card
    var linearGrad: Color
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            
            if card.isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else { //EC 3
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
