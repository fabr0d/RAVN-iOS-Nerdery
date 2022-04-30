//
//  Shapes.swift
//  Set
//
//  Created by Fabrizio Flores on 25/04/22.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect : CGRect) -> Path {
        let top = CGPoint(x: rect.midX,  y: rect.minY )
        let right = CGPoint(x: rect.minX + rect.width, y: rect.midY )
        let down = CGPoint(x: rect.midX, y: rect.minY + rect.height)
        let left = CGPoint(x: rect.minX , y: rect.midY)
            
        var path = Path()
        path.move(to: top)
        path.addLine(to : right)
        path.addLine(to: down)
        path.addLine(to: left)
        path.addLine(to: top)

        return path
    }
}
