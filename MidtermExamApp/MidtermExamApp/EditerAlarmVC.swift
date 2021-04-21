//
//  EditerAlarmVC.swift
//  MidtermExamApp
//
//  Created by Zhaisan on 12.03.2021.
//

import UIKit

class EditerAlarmVC: UIViewController {
    
    var timesString: String?
    var notesString: String?
    var changeProtocol: ChangeAlarm?
    var deleteProtocol: DeleteAlarm?
    var index = 0
    
    
    @IBOutlet weak var myPicker: UIDatePicker!
    

    @IBOutlet weak var myText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        myText.delegate = self
        myText.text = notesString
        
    }
    
    
    
    @IBAction func deleteButton(_ sender: UIButton) {
        deleteProtocol?.deleteAlarm(index: index)
        navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func changeButton(_ sender: UIButton) {
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
        timesString = "\(hour) : \(minute)"
        changeProtocol?.changeAlarm(timesString: timesString!, notesString: myText.text!, index: index)
        navigationController?.popViewController(animated: true)
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

extension EditerAlarmVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
