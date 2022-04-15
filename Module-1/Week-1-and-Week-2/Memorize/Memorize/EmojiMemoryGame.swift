//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Fabrizio Flores on 12/04/22.
//
//ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    static var globalThemes: [Theme] = [
        Theme(themeName: "Places", emojiList: HelpFunctions.hexRangeToStringArray(range: 0x1F3E0...0x1F3F0), color: "#FF0000"), //17Elements
        Theme(themeName: "Food", emojiList: HelpFunctions.hexRangeToStringArray(range: 0x1F950...0x1F95E), color: "#00FF00"), //15Elements
        Theme(themeName: "Animals", emojiList: HelpFunctions.hexRangeToStringArray(range: 0x1F985...0x1F991), color: "#0000FF"), //13Elements
        Theme(themeName: "Zodiac", emojiList: HelpFunctions.hexRangeToStringArray(range: 0x2648...0x2653), color: "#FFFF00"), //12Elements
        Theme(themeName: "Japanese", emojiList: HelpFunctions.hexRangeToStringArray(range: 0x1F232...0x1F236), color: "#00FFFF"), //5Elements
        Theme(themeName: "Faces", emojiList: HelpFunctions.hexRangeToStringArray(range: 0x1F973...0x1F976), color: "#FF00FF") //4Elements
    ] //8, 9
    
    static func createMemoryGame(randomNum: Int) -> MemoryGame<String> {
        return MemoryGame<String>(theme: globalThemes[randomNum])
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame(randomNum: Int.random(in: 0..<globalThemes.count))
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
        
    var themeName: String {
        return model.themeOnDisplay.name
    }
    
    var getColorCard: Color {
        return Color(hex: model.themeOnDisplay.cardColor)
    }
    
    var getScore: Int {
        return model.score
    }
    
    func choose (_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame () { //11
        model = EmojiMemoryGame.createMemoryGame(randomNum: Int.random(in: 0..<EmojiMemoryGame.globalThemes.count))
    }
}
