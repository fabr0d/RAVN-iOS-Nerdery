//
//  Card.swift
//  Memorize
//
//  Created by Fabrizio Flores on 19/04/22.
//

import Foundation

struct Card<CardContent>: Identifiable {
    var isFaceUp: Bool = false //12
    var isMatched: Bool = false
    var wasSeenBefore: Bool = false
    var content: CardContent
    var id: Int
}
