//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Fabrizio Flores on 12/04/22.
//
//ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    typealias vmCard = Card<String>
    
    @Published private var model = createMemoryGame(randomNum: Int.random(in: 0..<globalThemes.count))
    
    private static var globalThemes: [Theme] = [
        Theme("Places", HelpFunctions.hexRangeToStringArray(range: 0x1F3E0...0x1F3F0), "#FF0000"), //17Elements
        Theme("Food", HelpFunctions.hexRangeToStringArray(range: 0x1F950...0x1F95E), "#00FF00"), //15Elements
        Theme("Animals", HelpFunctions.hexRangeToStringArray(range: 0x1F985...0x1F991), "#0000FF"), //13Elements
        Theme("Zodiac", HelpFunctions.hexRangeToStringArray(range: 0x2648...0x2653), "#FFFF00"), //12Elements
        Theme("Japanese", HelpFunctions.hexRangeToStringArray(range: 0x1F232...0x1F236), "#00FFFF"), //5Elements
        Theme("Faces", HelpFunctions.hexRangeToStringArray(range: 0x1F973...0x1F976), "#FF00FF") //4Elements
    ] //8, 9
    
    var cards: Array<vmCard> {
        model.cards
    }
        
    var themeName: String {
        model.themeOnDisplay.name
    }
    
    var getColorCard: Color {
        Color(hex: model.themeOnDisplay.cardColor)
    }
    
    var getScore: Int {
        model.score
    }
    
    private static func createMemoryGame(randomNum: Int) -> MemoryGame<String> {
        MemoryGame<String>(globalThemes[randomNum])
    }
    
    func choose(_ card: vmCard) {
        model.choose(card)
    }
    
    func newGame() { //11
        model = EmojiMemoryGame.createMemoryGame(randomNum: Int.random(in: 0..<EmojiMemoryGame.globalThemes.count))
    }
}
