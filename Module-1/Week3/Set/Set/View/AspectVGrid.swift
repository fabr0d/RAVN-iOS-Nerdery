//
//  AspectVGrid.swift
//  Set
//
//  Created by Fabrizio Flores on 25/04/22.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    var isPileOrDeck: Bool
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView, isPileOrDeck: Bool) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
        self.isPileOrDeck = isPileOrDeck
    }
    
    var body: some View {
        if !isPileOrDeck {
            GeometryReader { geometry in
                VStack {
                    let width: CGFloat = widthThatFits(itemCount: items.count, in: geometry.size, itemsAspectRatio: aspectRatio)
                    
                    LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                        ForEach(items) { item in
                            content(item).aspectRatio(aspectRatio, contentMode: .fit)
                        }
                    }
                }
            }
        } else {
            ZStack {
                ForEach(items) { item in
                    content(item).aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
        
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func widthThatFits(itemCount: Int, in availableSize: CGSize, itemsAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        
        repeat {
            let itemWidth = availableSize.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemsAspectRatio
            if CGFloat(rowCount) * itemHeight < availableSize.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        if columnCount > itemCount {
            columnCount = itemCount
        }
        return floor(availableSize.width / CGFloat(columnCount))
    }
}
