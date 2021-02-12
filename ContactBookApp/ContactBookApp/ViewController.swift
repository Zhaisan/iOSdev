//
//  ViewController.swift
//  ContactBookApp
//
//  Created by Zhaisan on 11.02.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var students = [Student.init("Zhaisan Sarsengaliyev", "8771-191-23-49", UIImage.init(named: "male")!),
                    Student.init("Ali Kerimbaev", "8775-208-07-27", UIImage.init(named: "male")!)]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as? CustomCell
        
        cell?.studentName.text = students[indexPath.row].name_surname
        cell?.studentGpa.text = students[indexPath.row].gpa
        cell?.studentImageView.image = students[indexPath.row].image
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            students.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//        navigationController?.pushViewController(detailVC, animated: true)
        myTableView.deselectRow(at: indexPath, animated: true)
    }

    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index = myTableView.indexPathForSelectedRow?.row{
            let destination = segue.destination as! DetailViewController
            destination.name_surname = students[index].name_surname
            destination.gpa = students[index].gpa
            destination.image = students[index].image
        }
    }


}

