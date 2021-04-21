//
//  Alarm.swift
//  MidtermExamApp
//
//  Created by Zhaisan on 12.03.2021.
//

import Foundation
import UIKit

class Alarm{
    
    var timesString: String?
    var notesString: String?
    var isSwitched: Bool?
    
    init(timesString: String, notesString: String, isSwitched: Bool) {
        self.timesString = timesString
        self.notesString = notesString
        self.isSwitched = isSwitched
    }

}
