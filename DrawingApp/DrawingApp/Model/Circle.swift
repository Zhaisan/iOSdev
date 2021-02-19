//
//  Circle.swift
//  DrawingApp
//
//  Created by Zhaisan on 18.02.2021.
//

import Foundation
import UIKit

class Circle: Shape{
    private var radius: CGFloat
    private var circle_center: CGPoint
    private var color: UIColor
    private var stroke_width: CGFloat = 0.0
    private var isFilled: Bool
    
    init(_ radius: CGFloat,_ circle_center: CGPoint,_ color: UIColor,
         _ stroke_width: CGFloat,_ isFilled: Bool){
        self.circle_center = circle_center
        self.radius = radius
        self.isFilled = isFilled
        self.stroke_width = stroke_width
        self.color = color
    }
    
    func drawPath(){
        let path = UIBezierPath(arcCenter: circle_center,
                                radius: radius,
                                startAngle: 0,
                                endAngle: 2 * Double.pi.cg,
                                clockwise: true)
        path.lineWidth = stroke_width
        color.set()
        (isFilled) ? (path.fill()) : (path.stroke())
//        if isFilled{
//            path.fill()
//        }else{
//            path.stroke()
//        }
    }
}
extension Double{
    var cg: CGFloat{
        return CGFloat(self)
    }
}

