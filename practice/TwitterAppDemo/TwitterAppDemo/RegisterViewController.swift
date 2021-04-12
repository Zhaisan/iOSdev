//
//  RegisterViewController.swift
//  TwitterApp
//
//  Created by Zhaisan on 08.04.2021.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {


    @IBOutlet weak var email_field: UITextField!
    
    
    @IBOutlet weak var password_field: UITextField!
    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func register_clicked(_ sender: UIButton) {
        let email = email_field.text
        let password = password_field.text
        if email != "" && password != ""{
            indicator.startAnimating()
            Auth.auth().createUser(withEmail: email!, password: password!){ [weak self] (result, error) in
                self?.indicator.stopAnimating()
                Auth.auth().currentUser?.sendEmailVerification(completion: nil)
                if error == nil{
                    self?.showMessage(title: "Success", message: "Please verify your email")
                }
                else{
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
    func showMessage(title: String, message: String){
        //create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        //add an action (button)
        let ok = UIAlertAction(title: "OK", style: .default){
            (UIAlertAction) in
            if title != "Error"{
                self.dismiss(animated: true, completion: nil)
            }
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }

}
