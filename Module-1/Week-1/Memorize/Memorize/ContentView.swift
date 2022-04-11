//
//  ContentView.swift
//  Memorize
//
//  Created by Fabrizio Flores on 5/04/22.
//

import SwiftUI

struct ListsOfEmojis {
    static let placesEmojis = HelpFunctions.hexRangeToStringArray(range: 0x1F3E0...0x1F3F0)
    static let foodsEmojis = HelpFunctions.hexRangeToStringArray(range: 0x1F950...0x1F95E)
    static let animalsEmojis = HelpFunctions.hexRangeToStringArray(range: 0x1F985...0x1F991)
}

struct ContentView: View {
    @State private var onScreenEmojis: [String] = ListsOfEmojis.placesEmojis
    @State private var cardViewArray: [CardView] = HelpFunctions.cardViewArrayGenerator(emojisArray: ListsOfEmojis.placesEmojis)
    @State private var emojiCount: Int = Int.random(in: 4...ListsOfEmojis.placesEmojis.count)
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .padding(.all)
                .font(.largeTitle)
            
            ScrollView {
                
                LazyVGrid(
                    columns: [
                        GridItem(
                            .adaptive(
                                minimum: HelpFunctions.widthThatBestFits(cardCount: emojiCount)
                            )
                        )
                    ]
                ){
                    ForEach(cardViewArray[0..<emojiCount], id: \.id) { cardViewEmoji in
                        cardViewEmoji.aspectRatio(2/3, contentMode: .fit)
                    }
                }.foregroundColor(.red)
            }
            
            HStack {
                setPlaces.padding(.horizontal)
                
                setFoods.padding(.horizontal)
                
                setAnimals.padding(.horizontal)
            }
            .font(.title)
            .padding(.horizontal)
        }
        .padding(.horizontal)
        
    }
    
    var setPlaces: some View{
        Button {
            onScreenEmojis = ListsOfEmojis.placesEmojis.shuffled()
            cardViewArray = HelpFunctions.cardViewArrayGenerator(emojisArray: onScreenEmojis)
            emojiCount = Int.random(in: 4...cardViewArray.count)
        } label: {
            VStack {
                Image(systemName: "house.fill")
                
                Text("Places").font(.subheadline)
            }
        }
    }
    
    var setFoods: some View{
        Button {
            onScreenEmojis = ListsOfEmojis.foodsEmojis.shuffled()
            cardViewArray = HelpFunctions.cardViewArrayGenerator(emojisArray: onScreenEmojis)
            emojiCount = Int.random(in: 4...cardViewArray.count)
        } label: {
            VStack {
                Image(systemName: "fork.knife")
                
                Text("Foods").font(.subheadline)
            }
        }
    }
    
    var setAnimals: some View{
        Button {
            onScreenEmojis = ListsOfEmojis.animalsEmojis.shuffled()
            cardViewArray = HelpFunctions.cardViewArrayGenerator(emojisArray: onScreenEmojis)
            emojiCount = Int.random(in: 4...cardViewArray.count)
        } label: {
            VStack {
                Image(systemName: "pawprint.fill")
                
                Text("Animals").font(.subheadline)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
            ContentView()
                .preferredColorScheme(.dark)
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
