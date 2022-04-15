//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Fabrizio Flores on 5/04/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
