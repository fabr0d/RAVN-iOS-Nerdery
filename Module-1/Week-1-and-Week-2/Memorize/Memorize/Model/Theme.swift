//
//  Theme.swift
//  Memorize
//
//  Created by Fabrizio Flores on 19/04/22.
//

import Foundation

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
        
        if !randomOrAll { //EC 1, 2
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
