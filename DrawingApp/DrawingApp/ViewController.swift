//
//  ViewController.swift
//  DrawingApp
//
//  Created by Zhaisan on 18.02.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customViewControl: CustomView!
    
    @IBOutlet weak var Undo: UIButton!
    
    var shapes: Array<Shapes> = [.circle, .rectangle, .line, .triangle, .pencil]
    var colors: Array<UIColor> = [.green, .blue, .yellow, .systemTeal, .red, .purple, .orange]
    override func viewDidLoad() {
        super.viewDidLoad()
        //Tapping
        let OneTap = UITapGestureRecognizer(target: self, action: #selector (tap))
        let LongTap = UILongPressGestureRecognizer(target: self, action: #selector(long))
        OneTap.numberOfTapsRequired = 1
        Undo.addGestureRecognizer(OneTap)
        Undo.addGestureRecognizer(LongTap)
    }
    
    
    @IBAction func ShapePressed(_ sender: UIButton) {
        Menu.shape = shapes[sender.tag]
    }
    
    
    @IBAction func FillPressed(_ sender: UISwitch) {
        Menu.isFilled = sender.isOn
    }
    
    
    @IBAction func ColorPressed(_ sender: UIButton) {
        Menu.color = colors[sender.tag]
    }
    
    @objc func tap() {
        if Menu.arrs.count > 0 {
            Menu.arrs.removeLast()
            customViewControl.setNeedsDisplay()
        }
    }
    
    @objc func long() {
        if Menu.arrs.count > 0 {
            Menu.arrs.removeAll()
            customViewControl.setNeedsDisplay()
        }
    }


}

