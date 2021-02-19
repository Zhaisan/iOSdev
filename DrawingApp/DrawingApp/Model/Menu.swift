//
//  Menu.swift
//  DrawingApp
//
//  Created by Zhaisan on 19.02.2021.
//

import Foundation
import UIKit


enum Shapes {
    case circle
    case rectangle
    case line
    case triangle
    case pencil
}

struct Menu{
    static var color: UIColor! = .green
    static var isFilled: Bool! = false
    static var stroke_width: CGFloat! = 5
    static var shape: Shapes! = Shapes.circle
    static var arrs: Array<Shape>! = []
}

