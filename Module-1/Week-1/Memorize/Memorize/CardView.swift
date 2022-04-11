//
//  CardView.swift
//  Memorize
//
//  Created by Fabrizio Flores on 11/04/22.
//

import SwiftUI

struct CardView: View {
    var id = UUID()
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            
            if isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(content: "🐳")
                .preferredColorScheme(.dark)
            CardView(content: "🐳")
                .preferredColorScheme(.light)
        }
    }
}
