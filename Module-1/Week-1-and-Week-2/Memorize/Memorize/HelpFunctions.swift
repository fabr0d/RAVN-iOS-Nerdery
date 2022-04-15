//
//  HelpFunctions.swift
//  Memorize
//
//  Created by Fabrizio Flores on 11/04/22.
//

import SwiftUI

extension Color { //From stackoverflow.com/questions/56874133/use-hex-color-in-swiftui
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct HelpFunctions {
    static func hexRangeToStringArray(range: ClosedRange<Int>) -> [String] {
        var emojiList = [String]()
        for i in range {
            let emoji = String(UnicodeScalar(i) ?? "-")
            emojiList.append(emoji)
        }
        return emojiList
    }
    
    static func widthThatBestFits(cardCount: Int) -> CGFloat {
        if cardCount < 5 {
            return 130
        } else if cardCount < 10 {
            return 90
        } else if cardCount < 17 {
            return 80
        }
        return 60
    }
    
    static func specialScore(firstTime: Date, secondTime: Date, factor: Int, addOrSubtract: Bool) -> Int
    { //EC 4
        let diference: Double = firstTime.distance(to: secondTime)
        if addOrSubtract == true {
            if diference > 3 {
                return 1 * factor
            }
            return ( 3 - Int(diference.rounded()) ) * factor
        }
        else {
            if diference > 10 {
                return 10 * factor
            }
            return Int(diference.rounded()) * factor
        }
    }
}
