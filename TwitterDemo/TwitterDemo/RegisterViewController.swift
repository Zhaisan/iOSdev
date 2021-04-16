//
//  RegisterViewController.swift
//  TwitterDemo
//
//  Created by Zhaisan on 11/04/21.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {
    var ref: DatabaseReference!
    @IBOutlet weak var date_picker: UIDatePicker!
    @IBOutlet weak var surname_field: UITextField!
    @IBOutlet weak var name_field: UITextField!
    @IBOutlet weak var email_field: UITextField!
    @IBOutlet weak var password_field: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func register_clicked(_ sender: UIButton) {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        let email = email_field.text
        let password = password_field.text
        let date = df.string(from: date_picker.date)
        let name = name_field.text
        let surname = surname_field.text
        
        
        if email != "" && password != ""  && name != "" && surname != ""{
            indicator.startAnimating()
            Auth.auth().createUser(withEmail: email!, password: password!) { [weak self] (result, error) in
                self?.indicator.stopAnimating()
                Auth.auth().currentUser?.sendEmailVerification(completion: nil)
                if error == nil {
                    self?.showMessage(title: "Success", message: "Please verify your email")
                    let userData = ["name": name ,
                                    "surname": surname,
                                    "date": date
                                    ]
                    self!.ref.child("users").child(Auth.auth().currentUser!.uid).setValue(userData)
                    
                }
                else {
                    self?.showMessage(title: "Error", message: "Some problem occured")
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func showMessage(title: String, message: String) {
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        // add an action (buttoon)
        let ok = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            if title != "Error" {
                self.dismiss(animated: true, completion: nil)
            }
        }
        alert.addAction(ok)
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
