//
//  CustomCell.swift
//  MidtermExamApp
//
//  Created by Zhaisan on 12.03.2021.
//

import UIKit

class CustomCell: UITableViewCell {

    
    
    
    @IBOutlet weak var time: UILabel!
    
   
    @IBOutlet weak var note: UILabel!
    
    
    @IBOutlet weak var switched: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
