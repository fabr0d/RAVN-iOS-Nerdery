//
//  CardView.swift
//  Memorize
//
//  Created by Fabrizio Flores on 11/04/22.
//

import SwiftUI

//struct CardView: View {
//    let card: MemoryGame<String>.Card
//
//    var body: some View {
//        ZStack {
//            let shape = RoundedRectangle(cornerRadius: 20.0)
//            
//            if card.isFaceUp {
//                shape.fill(.white)
//                shape.strokeBorder(lineWidth: 3)
//                Text(card.content).font(.largeTitle)
//            } else if card.isMatched {
//                shape.opacity(0)
//            } else {
//                shape.fill()
//            }
//            
//            
//        }
//    }
//}
//
// struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            CardView(content: "🐳")
//                .preferredColorScheme(.dark)
//            CardView(content: "🐳")
//                .preferredColorScheme(.light)
//        }
//    }
// }



struct Card: Equatable {
    var isMatched = false
    let symbol: String
    let quantity: Int
    let color: String
    let shade: String
    let id: Int
    
}

let card1 = Card()