//
//  EditViewController.swift
//  TwitterDemo
//
//  Created by Zhaisan on 11/04/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class EditViewController: UIViewController {
    var ref: DatabaseReference!
    var current_user: User?
    @IBOutlet weak var name_field: UITextField!
    @IBOutlet weak var surname_field: UITextField!
    @IBOutlet weak var date_field: UIDatePicker!
    var name: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        current_user = Auth.auth().currentUser
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { [self] (snapshot) in
          // Get user value
          let value = snapshot.value as? NSDictionary
            name_field.text = value?["name"] as? String ?? ""
            name = value?["name"] as? String ?? ""
            surname_field.text = value?["surname"] as? String ?? ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  "dd.MM.yyyy"
            let date = dateFormatter.date(from: (value?["date"] as? String)!)
            
            date_field.date = date!
            
          // ...
          }) { (error) in
            print(error.localizedDescription)
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveClicked(_ sender: UIButton) {
        self.ref.child("users/\(Auth.auth().currentUser!.uid)/name").setValue(name_field.text)
        self.ref.child("users/\(Auth.auth().currentUser!.uid)/surname").setValue(surname_field.text)
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        let date = df.string(from: date_field.date)
        self.ref.child("users/\(Auth.auth().currentUser!.uid)/date").setValue(date)
        self.dismiss(animated: true, completion: nil)
        
        let usersRef = ref.child("tweets")
            let queryRef = usersRef.queryOrdered(byChild: "name").queryEqual(toValue: name)
        queryRef.observeSingleEvent(of: .value, with: { [self] (snapshot) in

                for snap in snapshot.children {
                    let userSnap = snap as! DataSnapshot
                    let uid = userSnap.key //the uid of each user
                    let userDict = userSnap.value as! [String:AnyObject]
                    let timestamp = userDict["name"] as! String
                    self.ref.child("tweets/\(uid)/name").setValue(name_field.text)
                    self.ref.child("tweets/\(uid)/surname").setValue(surname_field.text)
                    print("key = \(uid) and timestamp = \(timestamp)")
                }
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
