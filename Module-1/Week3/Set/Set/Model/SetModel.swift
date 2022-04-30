//
//  SetModel.swift
//  Set
//
//  Created by Fabrizio Flores on 21/04/22.
//

import Foundation

struct SetGame<CardContent> where CardContent: Hashable {
    
    private(set) var cards: [Card]
    private(set) var cardsOnBoard = [Card]()
    private(set) var deck = [Card]()
    private(set) var discardPile = [Card]()
    private(set) var potentialSet = [Card]()
    
    init(createCardContent: () -> Set<CardContent>) {
        cards = Array<Card>()
        let content = createCardContent()
        for card in content {
            cards.append(Card(content: card))
        }
        deal()
    }
    
    mutating func choose(_ card: Card) {
        if !card.isOnDeck { //card on the table
            if potentialSet.count < 3 {
                //print(potentialSet)
                if let chosenIndex = cardsOnBoard.firstIndex(where: { $0.id == card.id }) {
                    cardsOnBoard[chosenIndex].isSelected.toggle()
                    
                    if cardsOnBoard[chosenIndex].isSelected {
                        potentialSet.append(cardsOnBoard[chosenIndex])
                    } else {
                        if let removeIndex = potentialSet.firstIndex(where: { $0.id == card.id }) {
                            potentialSet.remove(at: removeIndex)
                        }
                    }
                }
            } else {
                
                //print(potentialSet)
                
                replaceCards()
                
                for index in cardsOnBoard.indices {
                    cardsOnBoard[index].isSelected = false
                    cardsOnBoard[index].isMatched = nil
                }
                potentialSet.removeAll()
                
                if let chosenIndex = cardsOnBoard.firstIndex(where: { $0.id == card.id }) {
                    cardsOnBoard[chosenIndex].isSelected.toggle()
                    potentialSet.append(cardsOnBoard[chosenIndex])
                }
            }
        }
    }
    
    mutating func areMatched(checkForMatch: () -> Bool) {
        
        if checkForMatch() {
            print("set found!")
            for card in potentialSet {
                if let index = cardsOnBoard.firstIndex(where: { $0.id == card.id }) {
                    cardsOnBoard[index].isMatched = true
                }
            }
            for index in potentialSet.indices {
                potentialSet[index].isMatched = true
            }
            
        } else {
            for card in potentialSet {
                if let index = cardsOnBoard.firstIndex(where: { $0.id == card.id }) {
                    cardsOnBoard[index].isMatched = false
                }
            }
        }
    }
    
    mutating func deal() {
        if deck.isEmpty && cardsOnBoard.isEmpty { //initial game setup
            for index in 0...11 {
                cards[index].isOnDeck = false
                cardsOnBoard.append(cards[index])
            }
            for index in 12...cards.count-1 {
                cards[index].isOnDeck = true // only 4 be sure
                deck.append(cards[index])
            }
        } else if cardsOnBoard.contains(where: { $0.isMatched == true }) { //if cards on the table are matched, look
            replaceCards()
        } else {
            if deck.count >= 3 {
                for _ in 0...2 {
                    var temporalCard: Card = deck[deck.count-1]
                    temporalCard.isOnDeck = false
                    cardsOnBoard.append(temporalCard)
                    deck.removeLast()
                }
            }
        }
    }
    
    mutating func replaceCards() {
        for card in potentialSet {
            if let match = card.isMatched {
                if match { //Set founded
                    if let index = cardsOnBoard.firstIndex(where: { $0.id == card.id }) {
                        cardsOnBoard[index].isOnDP = true
                        discardPile.append(cardsOnBoard[index])
                        cardsOnBoard.remove(at: index)
                    }
                }
            }
        }
    }
    struct Card: Identifiable {
        let id = UUID()
        let content: CardContent
        var isSelected = false
        var isMatched: Bool?
        var isOnDeck = true
        var isOnDP = false
    }

}
