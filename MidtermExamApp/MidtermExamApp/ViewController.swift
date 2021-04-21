//
//  ViewController.swift
//  MidtermExamApp
//
//  Created by Zhaisan on 12.03.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    var alarm = [Alarm.init(timesString: "13:00", notesString: "Lunch", isSwitched: true),
                 Alarm.init(timesString: "15:00", notesString: "Android lecture", isSwitched: false),
                 Alarm.init(timesString: "16:00", notesString: "Break", isSwitched: true),
                 Alarm.init(timesString: "19:00", notesString: "Dinner", isSwitched: false),
                 Alarm.init(timesString: "22:00", notesString: "Football game", isSwitched: true)]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Alarms"
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        alarm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as? CustomCell
        cell?.time.text = alarm[indexPath.row].timesString
        cell?.note.text = alarm[indexPath.row].notesString
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            alarm.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = myTableView.indexPathForSelectedRow?.row
        if segue.identifier == "addSegue" {
            let destination = segue.destination as! NewAlarmVC
            destination.myProtocol = self
        }
        else {
            let destination = segue.destination as! EditerAlarmVC
            destination.timesString = alarm[index!].timesString
            destination.notesString = alarm[index!].notesString
            destination.index = index!
            destination.changeProtocol = self
            destination.deleteProtocol = self
            
        }
    }


}

extension ViewController: AddAlarm {
    func addAlarm(timesString: String, notesString: String, isSwitched: Bool) {
        let addingAlarm = Alarm.init(timesString: timesString, notesString: notesString, isSwitched: false)
        alarm.append(addingAlarm)
        myTableView.reloadData()
    }
}

extension ViewController: ChangeAlarm {
    func changeAlarm(timesString: String, notesString: String, index: Int) {
        alarm[index].timesString = timesString
        alarm[index].notesString = notesString
        myTableView.reloadData()
    }
}

extension ViewController: DeleteAlarm {
    func deleteAlarm(index: Int) {
        alarm.remove(at: index)
        myTableView.reloadData()
    }
}
