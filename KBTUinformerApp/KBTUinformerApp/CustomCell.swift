//
//  CustomCell.swift
//  KBTUinformerApp
//
//  Created by Zhaisan on 12.03.2021.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var facultyImageView: UIImageView!
    
    @IBOutlet weak var facultyName: UILabel!
    
    
    @IBOutlet weak var facultyDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
