//
//  NewAlarmVC.swift
//  MidtermExamApp
//
//  Created by Zhaisan on 12.03.2021.
//

import UIKit

class NewAlarmVC: UIViewController {
    
    var timesString: String?
    var notesString: String?
    var myProtocol: AddAlarm?
    
    
    
    
    @IBOutlet weak var myPicker: UIDatePicker!
    
    
    @IBOutlet weak var myText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myText.text = notesString
        myText.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    
    @IBAction func saveButton(_ sender: UIButton) {
        let times = myPicker.calendar.dateComponents([.hour, .minute], from: myPicker.date)
        var hour = ""
        var minute = ""
        if times.hour! < 10 {
            hour = "0\(times.hour!)"
        }
        if times.hour! >= 10 {
            hour = "\(times.hour!)"
        }
        if times.minute! < 10 {
            minute = "0\(times.minute!)"
        }
        if times.minute! >= 10 {
            minute = "\(times.minute!)"
        }
        let timesString = "\(hour) : \(minute)"
        myProtocol?.addAlarm(timesString: timesString, notesString: myText.text!, isSwitched: false)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension NewAlarmVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
