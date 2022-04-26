//
//  Card.swift
//  Memorize
//
//  Created by Fabrizio Flores on 19/04/22.
//

import Foundation

struct Card<CardContent>: Identifiable {
    var isFaceUp = true //12
    var isMatched = false
    var wasSeenBefore = false
    let content: CardContent
    let id: Int
}
