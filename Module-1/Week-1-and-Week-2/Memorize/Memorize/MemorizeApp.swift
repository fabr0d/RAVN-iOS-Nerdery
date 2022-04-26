//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Fabrizio Flores on 5/04/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
