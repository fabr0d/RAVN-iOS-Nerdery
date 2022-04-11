//
//  HelpFunctions.swift
//  Memorize
//
//  Created by Fabrizio Flores on 11/04/22.
//

import SwiftUI

struct HelpFunctions {
    static func hexRangeToStringArray(range: ClosedRange<Int>) -> [String] {
        var emojiList = [String]()
        for i in range {
            let emoji = String(UnicodeScalar(i) ?? "-")
            emojiList.append(emoji)
        }
        return emojiList
    }
    
    static func cardViewArrayGenerator(emojisArray: [String]) -> [CardView] {
        var cardViewArray = [CardView]()
        for i in 0..<emojisArray.count {
            let temporalCardView = CardView(content: emojisArray[i])
            cardViewArray.append(temporalCardView)
        }
        return cardViewArray
    }
    
    static func widthThatBestFits(cardCount: Int) -> CGFloat {
        if cardCount < 5 {
            return 130
        } else if cardCount < 10{
            return 90
        } else if cardCount < 17 {
            return 80
        }
        return 60
    }
}
