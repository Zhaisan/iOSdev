//
//  CustomView.swift
//  DrawingApp
//
//  Created by Zhaisan on 18.02.2021.
//

import UIKit

class CustomView: UIView {

    var point1: CGPoint?
    var point2: CGPoint!
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        for arr in Menu.arrs {
            arr.drawPath()
        }
    }
    
    
    func addFigure() {
        if point1 != nil {
            let color = Menu.color
            let stroke_width = Menu.stroke_width
            let isFilled = Menu.isFilled
            
            switch Menu.shape {
            case .circle:
                let radius = abs(point2.x - point1!.x) / 2
                let center = CGPoint(x : (point2.x + point1!.x) / 2, y : (point2.y + point1!.y) / 2)
                let circle = Circle(radius, center, color!, stroke_width!, isFilled!)
                Menu.arrs.append(circle)
                
            case .rectangle:
                let pointOne = CGPoint(x: min(point1!.x, point2.x), y: min(point1!.y, point2.y))
                let pointTwo = CGPoint(x: max(point1!.x, point2.x), y: max(point1!.y, point2.y))
                let rectangle = Rectangle(pointOne, pointTwo, color!, stroke_width!, isFilled!)
                Menu.arrs.append(rectangle)
                
                
            case .triangle:
                let pointOne = CGPoint(x: min(point1!.x, point2.x), y: min(point1!.y, point2.y))
                let pointTwo = CGPoint(x: max(point1!.x, point2.x), y: max(point1!.y, point2.y))
                let triangle = Triangle(pointOne, pointTwo, color!, stroke_width!, isFilled!)
                Menu.arrs.append(triangle)

                
            case .line:
                let line = Line(point1!, point2, color!, stroke_width!)
                Menu.arrs.append(line)
                
                
            case .pencil:
                let line = Line(point1!, point2, color!, stroke_width!)
                Menu.arrs.append(line)
                
            default:
                break
            }
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            point1 = touch.location(in: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if Menu.shape == Shapes.pencil {
                point2 = touch.location(in: self)
                addFigure()
                point1 = point2
                setNeedsDisplay()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            point2 = touch.location(in: self)
        }
        addFigure()
        setNeedsDisplay()
    }

}

protocol Shape{
    func drawPath()
}






