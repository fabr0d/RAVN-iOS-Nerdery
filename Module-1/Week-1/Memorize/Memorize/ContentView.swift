//
//  ContentView.swift
//  Memorize
//
//  Created by Fabrizio Flores on 5/04/22.
//

import SwiftUI

let PlacesRange: ClosedRange<Int> = 0x1F3E0...0x1F3F0
let FoodsRange: ClosedRange<Int> = 0x1F950...0x1F95E
let AnimalsRange: ClosedRange<Int> = 0x1F985...0x1F991

func HexRangeToStringArray (range: ClosedRange<Int>) -> [String]{
    var EmojiList: [String] = []
    for i in range {
        let emoji = String(UnicodeScalar(i) ?? "-")
        EmojiList.append(emoji)
    }
    return EmojiList
}

let PlacesEmojis = HexRangeToStringArray(range: PlacesRange)
let FoodsEmojis = HexRangeToStringArray(range: FoodsRange)
let AnimalsEmojis = HexRangeToStringArray(range: AnimalsRange)

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

func GenCardViewArray (emojis: [String]) -> [CardView]{
    var CardViewArray: [CardView] = []
    for i in 0..<emojis.count {
        let TcardView = CardView(content: emojis[i], isFaceUp: true)
        CardViewArray.append(TcardView)
    }
    return CardViewArray
}

func widthThatBestFits (CardCount: Int) -> CGFloat {
    if CardCount < 5 {
        return 130
    } else if CardCount < 10{
        return 90
    } else if CardCount < 17 {
        return 80
    }
    return 60
}

struct ContentView: View {
    @State var OnScreenEmojis: [String] = PlacesEmojis
    @State var CardViewArray: [CardView] = GenCardViewArray(emojis: PlacesEmojis)
    @State var emojiCount: Int = Int.random(in: 4...PlacesEmojis.count)
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
                                minimum: widthThatBestFits(CardCount: emojiCount)
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
            OnScreenEmojis = PlacesEmojis.shuffled()
            CardViewArray = GenCardViewArray(emojis: OnScreenEmojis)
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
            OnScreenEmojis = FoodsEmojis.shuffled()
            CardViewArray = GenCardViewArray(emojis: OnScreenEmojis)
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
            OnScreenEmojis = AnimalsEmojis.shuffled()
            CardViewArray = GenCardViewArray(emojis: OnScreenEmojis)
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
