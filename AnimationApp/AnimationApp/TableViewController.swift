//
//  TableViewController.swift
//  AnimationApp
//
//  Created by Zhaisan on 02.04.2021.
//

import UIKit

class TableViewController: UITableViewController {

    
    @IBOutlet var myTableView: UITableView!
    
    
    var phones: [Phone] = [Phone(name: "Samsung S20 Ultra", price: "1300$", camera: "Dual-LED", detail: "12MPX"),
                           Phone(name: "iPhone 12", price: "1030$", camera: "Dual-LED", detail: "12MPX"),
                           Phone(name: "LG G4", price: "400$", camera: "Snapdragon 808", detail: "16MPX"),
                           Phone(name: "Nexus 6P", price: "700$", camera: "Snapdragon 810", detail: "12.3MPX"),
                           Phone(name: "iPhone 12 mini", price: "890$", camera: "Dual-LED", detail: "12MPX"),
                           Phone(name: "Google Pixel", price: "350$", camera: "Snapdragon 821", detail: "12MPX"),]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.separatorStyle = .none
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return phones.count
    }
    
    
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? CustomCell

        cell?.Name.text = phones[indexPath.row].name
        cell?.Price.text = phones[indexPath.row].price
        cell?.Info.text = phones[indexPath.row].detail
        cell?.Camera.text = phones[indexPath.row].camera
        cell?.Hide.backgroundColor = .clear
        cell?.Hide.layer.cornerRadius = 10
        cell?.Hide.layer.borderWidth = 1
        cell?.Hide.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        return cell!
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
