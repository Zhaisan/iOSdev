//
//  ViewController.swift
//  AnimationApp
//
//  Created by Zhaisan on 01.04.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstTF: UITextField!
    
    
    @IBOutlet weak var secondTF: UITextField!
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = 10
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
        // Do any additional setup after loading the view.
        
        UIView.animate(withDuration: 2) { [self] in
            firstTF.center = CGPoint(x: firstTF.layer.position.x + 200, y: firstTF.layer.position.y)
        }
        UIView.animate(withDuration: 2) { [self] in
            secondTF.center = CGPoint(x: secondTF.layer.position.x - 200, y: secondTF.layer.position.y)
        }
        UIView.animate(withDuration: 3, delay: 2) { [self] in
            nextButton.alpha = 1
        }
    }
    


}

