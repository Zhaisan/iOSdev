//
//  Triangle.swift
//  DrawingApp
//
//  Created by Zhaisan on 19.02.2021.
//

import Foundation
import UIKit

class Triangle: Shape{
    private var p1: CGPoint
    private var p2: CGPoint
    private var p3: CGPoint
    private var stroke_width: CGFloat = 0.0
    private var isFilled: Bool
    private var color: UIColor
    
    init(_ p1: CGPoint,_ p2: CGPoint,_ color: UIColor,_ stroke_width: CGFloat,_ isFilled: Bool) {
        self.p1 = p1
        self.p2 = p2
        self.p3 = CGPoint(x: CGFloat(min(p1.x, p2.x)), y: CGFloat(max(p1.y, p2.y)))
        self.color = color
        self.stroke_width = stroke_width
        self.isFilled = isFilled
    }
    
    func drawPath() {
        let linePath = UIBezierPath()
        linePath.move(to: p1)
        linePath.addLine(to: p2)
        linePath.addLine(to: p3)
        linePath.addLine(to: p1)
        
        linePath.lineWidth = stroke_width
        color.set()
        (isFilled) ? (linePath.fill()) : (linePath.stroke())
    }
}
