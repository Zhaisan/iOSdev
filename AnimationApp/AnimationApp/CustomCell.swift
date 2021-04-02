//
//  CustomCell.swift
//  AnimationApp
//
//  Created by Zhaisan on 02.04.2021.
//

import UIKit

class CustomCell: UITableViewCell {

    
    @IBOutlet weak var Info: UILabel!
    
    @IBOutlet weak var Camera: UILabel!
    
    @IBOutlet weak var Hide: UIButton!
    
    
    @IBOutlet weak var Name: UILabel!
    
    @IBOutlet weak var Price: UILabel!
    
    
    @IBOutlet weak var View2: UIView!
    
    @IBOutlet weak var View1: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func InfoButton(_ sender: UIButton) {
        UIView.transition(with: View1, duration: 0.5, options: .transitionFlipFromLeft) { [self] in
            self.View1.alpha =  1
            self.View1.isHidden = false
        }
    }
    
    @IBAction func HiddenButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.View1.frame.origin.x = self.View1.frame.width
            self.View1.alpha = 0
        } completion: { (Bool) in
            self.View1.frame.origin.x = 0
            self.View1.isHidden = true
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
