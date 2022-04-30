//
//  MemoryGame.swift
//  Memorize
//
//  Created by Fabrizio Flores on 12/04/22.
//
// Model

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card<String>>
    private(set) var themeOnDisplay: Theme
    private(set) var score: Int
    
    private(set) var firstClickTime: Date?
    private(set) var secondClickTime: Date?
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    mutating func choose(_ card: Card<String>) { //20
        
        if let chosenIndex = cards.firstIndex(where: { $0.id  == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            
            if let potenciaMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potenciaMatchIndex].content { //Match
                    
                    secondClickTime = Date()
                    
                    cards[chosenIndex].isMatched.toggle()
                    cards[chosenIndex].wasSeenBefore.toggle()
                    cards[potenciaMatchIndex].isMatched.toggle()
                    cards[potenciaMatchIndex].wasSeenBefore.toggle()
                    
                    score += HelpFunctions.specialScore(firstTime: firstClickTime!, secondTime: secondClickTime!, factor: 2, adds: true)
                    
                } else if !cards[chosenIndex].wasSeenBefore &&
                           !cards[potenciaMatchIndex].wasSeenBefore { //Missmatch without penalization
                    
                    cards[chosenIndex].wasSeenBefore.toggle()
                    cards[potenciaMatchIndex].wasSeenBefore.toggle()
                    
                }
                else if (cards[chosenIndex].wasSeenBefore && !cards[potenciaMatchIndex].wasSeenBefore) ||
                           (!cards[chosenIndex].wasSeenBefore && cards[potenciaMatchIndex].wasSeenBefore) { //MissMatch with *1 penalization
                    
                    secondClickTime = Date()
                    cards[chosenIndex].wasSeenBefore = true
                    cards[potenciaMatchIndex].wasSeenBefore = true
                    score -= HelpFunctions.specialScore(firstTime: firstClickTime!, secondTime: secondClickTime!, factor: 1, adds: false)
                    
                } else if cards[chosenIndex].wasSeenBefore && cards[potenciaMatchIndex].wasSeenBefore { //MissMatch with *2 penalization
                    
                    secondClickTime = Date()
                    score -= HelpFunctions.specialScore(firstTime: firstClickTime!, secondTime: secondClickTime!, factor: 2, adds: false)
                    
                }
                
                cards[chosenIndex].isFaceUp.toggle()
                firstClickTime = Date()
                
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    init(_ theme: Theme) {
        score = 0
        cards = []
        
        let emojiSetShuffled = theme.setOfEmojis.shuffled() //5
        themeOnDisplay = Theme(theme.name, emojiSetShuffled, theme.cardColor)
        
        for pairIndex in 0..<themeOnDisplay.numberOfPairs {
            let content: CardContent = themeOnDisplay.setOfEmojis[pairIndex] as! CardContent
            cards.append(Card(content: content as! String, id: pairIndex*2)) //6
            cards.append(Card(content: content as! String, id: pairIndex*2+1)) //6
        }
        cards = cards.shuffled() //13
    }
    
    
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
