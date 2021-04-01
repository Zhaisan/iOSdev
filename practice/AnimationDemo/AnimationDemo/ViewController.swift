//
//  ViewController.swift
//  AnimationDemo
//
//  Created by Zhaisan on 01.04.2021.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var target_image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func animatePressed(_ sender: UIButton) {
        switch sender.currentTitle {
        case "Fade out":
            UIView.animate(withDuration: 1){
                self.target_image.alpha = 0
            }
        case "Fade in":
            UIView.animate(withDuration: 1){
                self.target_image.alpha = 1
            }
        case "Move":
            UIView.animate(withDuration: 1){
                self.target_image.center = CGPoint(x: 0, y: 0)
            }
        case "Back":
            UIView.animate(withDuration: 1){
                self.target_image.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
            }
        case "Zoom in":
            UIView.animate(withDuration: 1){
                self.target_image.transform = CGAffineTransform(scaleX: 2, y: 2)
            }
        case "Zoom out":
            UIView.animate(withDuration: 1){
                self.target_image.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        default:
            break
        }
    }
    

}

