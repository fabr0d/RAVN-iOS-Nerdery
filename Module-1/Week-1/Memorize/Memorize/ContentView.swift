//
//  ContentView.swift
//  Memorize
//
//  Created by Fabrizio Flores on 5/04/22.
//

import SwiftUI

struct ContentView: View { //(: View) to contentView, im a view
    var emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛵", "🏍", "🚖", "🚝", "✈️"]
    //How u make a var editable for the view rebuild
    @State var emojiCount: Int = 15
    
    //some View, because body can have a multiple kind of views like text, hstack, vstack, etc.
    var body: some View {
        
        //VStack vertically sorts all elements within it
        VStack {
            
            //A scrollable view.
            ScrollView{
            
                //LazyVGrid arranges its child views in a grid that grows vertically, creating items only as needed, receives a GridItem() array and this items can have modifiers
                //Why Lazy? is lazy about accesing the body vars of all of its views
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]){
                    
                    //ForEach is a kind of loop, go through an entire array, although u can give ranges
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            //to make 2:3 aspect
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .foregroundColor(.red)
            }
            
            //HStack horizontally sorts all elements within it
            HStack{
                DeleteEmoji
                //Spacer take all the space it can
                Spacer()
                Text("Shuffle").foregroundColor(.blue)
                Spacer()
                AddEmoji
            }
            .font(.largeTitle) // for icon size
            .padding(.horizontal)
            
        }
        .padding(.horizontal)
        
    }
    
    var AddEmoji : some View{
        Button {
            if emojiCount < emojis.count { emojiCount += 1 }
        } label: {
            VStack {
                Image(systemName: "plus.app")
            }
        }
    }
    
    var DeleteEmoji: some View{
        Button {
            if emojiCount > 1 { emojiCount -= 1 }
        } label: {
            VStack {
                Image(systemName: "minus.square")
            }
        }
    }
}

struct CardView: View {
    
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        
        //ZStack overlays its children, aligning them in both axes
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if isFaceUp {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture { //instruction when touching on the element
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider { //glue preview to the contentView
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
