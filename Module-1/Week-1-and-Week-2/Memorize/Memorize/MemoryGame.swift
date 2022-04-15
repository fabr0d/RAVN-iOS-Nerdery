//
//  MemoryGame.swift
//  Memorize
//
//  Created by Fabrizio Flores on 12/04/22.
//
// Model

import Foundation
import SwiftUI

//3
struct Theme {
    var name: String
    var setOfEmojis: [String]
    var numberOfPairs: Int
    var cardColor: String
    init(themeName: String, emojiList: [String], color: String) {
        name = themeName
        setOfEmojis = emojiList
        cardColor = color
        let randomOrAll = Bool.random()
        
        if (randomOrAll ==  false) { //EC 1, 2
            if emojiList.count > 12 {
                numberOfPairs = 12
            } else {
                numberOfPairs = emojiList.count
            }
        } else {
            numberOfPairs = Int.random(in: 4...12)
            while numberOfPairs > setOfEmojis.count { //4, 7
                numberOfPairs = Int.random(in: 4...12)
            }
        }
    }
}

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var themeOnDisplay: Theme
    private(set) var score: Int
    
    private(set) var firstClickTime : Date?
    private(set) var secondClickTime : Date?
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose (_ card: Card) { //20
        if let chosenIndex = cards.firstIndex(where: { $0.id  == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            if let potenciaMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potenciaMatchIndex].content { //Match
                    secondClickTime = Date()
                    print("Match !")
                    cards[chosenIndex].isMatched = true
                    cards[chosenIndex].wasSeenBefore = true
                    cards[potenciaMatchIndex].isMatched = true
                    cards[potenciaMatchIndex].wasSeenBefore = true
                    score+=HelpFunctions.specialScore(firstTime: firstClickTime!, secondTime: secondClickTime!, factor: 2, addOrSubtract: true)
                } else if (cards[chosenIndex].wasSeenBefore == false &&
                           cards[potenciaMatchIndex].wasSeenBefore == false) { //Missmatch without penalization
                    print("Missmatch without penalization")
                    cards[chosenIndex].wasSeenBefore = true
                    cards[potenciaMatchIndex].wasSeenBefore = true
                }
                else if (cards[chosenIndex].wasSeenBefore == true &&
                           cards[potenciaMatchIndex].wasSeenBefore == false ||
                           cards[chosenIndex].wasSeenBefore == false &&
                           cards[potenciaMatchIndex].wasSeenBefore == true) { //MissMatch with *1 penalization
                    print("MissMatch with *1 penalization")
                    secondClickTime = Date()
                    cards[chosenIndex].wasSeenBefore = true
                    cards[potenciaMatchIndex].wasSeenBefore = true
                    score-=HelpFunctions.specialScore(firstTime: firstClickTime!, secondTime: secondClickTime!, factor: 1, addOrSubtract: false)
                    
                } else if (cards[chosenIndex].wasSeenBefore == true &&
                           cards[potenciaMatchIndex].wasSeenBefore == true) { //MissMatch with *2 penalization
                    print("MissMatch with *2 penalization")
                    secondClickTime = Date()
                    score-=HelpFunctions.specialScore(firstTime: firstClickTime!, secondTime: secondClickTime!, factor: 2, addOrSubtract: false)
                    
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
                
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
            firstClickTime = Date()
        }
    }
    
    init(theme: Theme) {
        score = 0
        cards = Array<Card>()
        
        let emojiSetShuffled = theme.setOfEmojis.shuffled() //5
        themeOnDisplay = Theme(themeName: theme.name, emojiList: emojiSetShuffled, color: theme.cardColor)
        
        for pairIndex in 0..<themeOnDisplay.numberOfPairs {
            let content: CardContent = themeOnDisplay.setOfEmojis[pairIndex] as! CardContent
            cards.append(Card(content: content, id: pairIndex*2)) //6
            cards.append(Card(content: content, id: pairIndex*2+1)) //6
        }
        cards = cards.shuffled() //13
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false //12
        var isMatched: Bool = false
        var wasSeenBefore: Bool = false
        var content: CardContent
        var id: Int
    }
}
