//
//  Rectangle.swift
//  DrawingApp
//
//  Created by Zhaisan on 18.02.2021.
//

import Foundation
import UIKit

class Rectangle: Shape{
    private var p1: CGPoint
    private var p2: CGPoint
    private var color: UIColor
    private var stroke_width: CGFloat = 0.0
    private var isFilled: Bool
    
    init(_ p1: CGPoint,_ p2: CGPoint,_ color: UIColor,_ stroke_width: CGFloat,_ isFilled: Bool){
        self.color = color
        self.isFilled = isFilled
        self.p1 = p1
        self.p2 = p2
        self.stroke_width = stroke_width
    }
    
    func drawPath(){
        let rectangle = CGRect(origin: p1,
                          size: CGSize(width: abs(p2.x - p1.x),
                          height: abs(p2.y - p1.y)))
        
        let path = UIBezierPath(rect: rectangle)
        path.lineWidth = stroke_width
        color.set()
        (isFilled) ? (path.fill()) : (path.stroke())
    }
}
