//
//  Theme.swift
//  Memorize
//
//  Created by Fabrizio Flores on 19/04/22.
//

import Foundation

struct Theme {
    var name: String
    var setOfEmojis: [String]
    var numberOfPairs: Int
    var cardColor: String
    
    init(_ name: String, _ setOfEmojis: [String], _ cardColor: String) {
        self.name = name
        self.setOfEmojis = setOfEmojis
        self.cardColor = cardColor
        let randomOrAll = Bool.random()
        
        if !randomOrAll {
            numberOfPairs = setOfEmojis.count
        } else {
            numberOfPairs = Int.random(in: 2...setOfEmojis.count)
        }
    }
}
