//
//  customCell.swift
//  TwitterDemo
//
//  Created by Zhaisan on 11/04/21.
//

import UIKit

class customCell: UITableViewCell {

    @IBOutlet weak var hashtag: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var surname: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
