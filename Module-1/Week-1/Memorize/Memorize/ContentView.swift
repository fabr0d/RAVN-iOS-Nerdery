//
//  ContentView.swift
//  Memorize
//
//  Created by Fabrizio Flores on 5/04/22.
//

import SwiftUI

struct HelpFunctions {
    static func HexRangeToStringArray (range: ClosedRange<Int>) -> [String]{
        var EmojiList: [String] = []
        for i in range {
            let emoji = String(UnicodeScalar(i) ?? "-")
            EmojiList.append(emoji)
        }
        return EmojiList
    }
    static func GenCardViewArray (emojis: [String]) -> [CardView]{
        var CardViewArray: [CardView] = []
        for i in 0..<emojis.count {
            let TcardView = CardView(content: emojis[i], isFaceUp: true)
            CardViewArray.append(TcardView)
        }
        return CardViewArray
    }
    static func WidthThatBestFits (CardCount: Int) -> CGFloat {
        if CardCount < 5 {
            return 130
        } else if CardCount < 10{
            return 90
        } else if CardCount < 17 {
            return 80
        }
        return 60
    }
}

struct ListsOfEmojis {
    static let PlacesEmojis = HelpFunctions.HexRangeToStringArray(range: 0x1F3E0...0x1F3F0)
    static let FoodsEmojis = HelpFunctions.HexRangeToStringArray(range: 0x1F950...0x1F95E)
    static let AnimalsEmojis = HelpFunctions.HexRangeToStringArray(range: 0x1F985...0x1F991)
}

struct CardView: View {
    var id = UUID()
    var content: String
    @State var isFaceUp: Bool = true
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView: View {
    @State var OnScreenEmojis: [String] = ListsOfEmojis.PlacesEmojis
    @State var CardViewArray: [CardView] = HelpFunctions.GenCardViewArray(emojis: ListsOfEmojis.PlacesEmojis)
    @State var emojiCount: Int = Int.random(in: 4...ListsOfEmojis.PlacesEmojis.count)
    var body: some View {
        VStack {
            Text("Memorize!")
                .padding(.all)
                .font(.largeTitle)
            ScrollView{
                LazyVGrid(
                    columns: [
                        GridItem(
                            .adaptive(
                                minimum: HelpFunctions.WidthThatBestFits(CardCount: emojiCount)
                            )
                        )
                    ]
                ){
                    ForEach(CardViewArray[0..<emojiCount], id: \.id) { CardViewEmoji in
                        CardViewEmoji.aspectRatio(2/3, contentMode: .fit)
                    }
                }.foregroundColor(.red)
            }
            HStack{
                SetPlaces.padding(.horizontal)
                SetFoods.padding(.horizontal)
                SetAnimals.padding(.horizontal)
            }
            .font(.title)
            .padding(.horizontal)
        }
        .padding(.horizontal)
        
    }
    var SetPlaces: some View{
        Button {
            OnScreenEmojis = ListsOfEmojis.PlacesEmojis.shuffled()
            CardViewArray = HelpFunctions.GenCardViewArray(emojis: OnScreenEmojis)
            emojiCount = Int.random(in: 4...CardViewArray.count)
        } label: {
            VStack {
                Image(systemName: "house.fill")
                Text("Places").font(.subheadline)
            }
        }
    }
    var SetFoods: some View{
        Button {
            OnScreenEmojis = ListsOfEmojis.FoodsEmojis.shuffled()
            CardViewArray = HelpFunctions.GenCardViewArray(emojis: OnScreenEmojis)
            emojiCount = Int.random(in: 4...CardViewArray.count)
        } label: {
            VStack {
                Image(systemName: "fork.knife")
                Text("Foods").font(.subheadline)
            }
        }
    }
    var SetAnimals: some View{
        Button {
            OnScreenEmojis = ListsOfEmojis.AnimalsEmojis.shuffled()
            CardViewArray = HelpFunctions.GenCardViewArray(emojis: OnScreenEmojis)
            emojiCount = Int.random(in: 4...CardViewArray.count)
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
                .preferredColorScheme(.light)
        }
    }
}
