//
//  Faculty.swift
//  KBTUinformerApp
//
//  Created by Zhaisan on 12.03.2021.
//

import Foundation
import UIKit
class Faculty{
    var fac_name: String?
    var description: String?
    var image: UIImage?
    init(_ fac_name: String, _ description: String, _ image: UIImage){
        self.fac_name = fac_name
        self.description = description
        self.image = image
    }
}
