//
//  Line.swift
//  DrawingApp
//
//  Created by Zhaisan on 19.02.2021.
//

import Foundation
import UIKit

class Line: Shape{
    private var p1: CGPoint
    private var p2: CGPoint
    private var stroke_width: CGFloat = 0.0
    private var color: UIColor
    
    init(_ p1: CGPoint,_ p2: CGPoint,_ color: UIColor,_ stroke_width: CGFloat) {
        self.p1 = p1
        self.p2 = p2
        self.color = color
        self.stroke_width = stroke_width
    }
    
    func drawPath() {
        let linePath = UIBezierPath()
        linePath.move(to: p1)
        linePath.addLine(to: p2)
        
        linePath.lineWidth = stroke_width
        color.set()
        linePath.stroke()
    }
}
