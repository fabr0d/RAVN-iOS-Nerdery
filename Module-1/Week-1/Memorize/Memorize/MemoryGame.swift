//
//  MemoryGame.swift
//  Memorize
//
//  Created by Fabrizio Flores on 12/04/22.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose (_ card: Card) {
        
    }
    
    struct Card {
        var isFaceUo: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
