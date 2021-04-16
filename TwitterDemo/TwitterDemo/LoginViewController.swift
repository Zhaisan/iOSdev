//
//  LoginViewController.swift
//  TwitterDemo
//
//  Created by Zhaisan on 11/04/21.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var email_field: UITextField!
    @IBOutlet weak var password_field: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func login_clicked(_ sender: UIButton) {
        let email = email_field.text
        let password = password_field.text
        indicator.startAnimating()
        if email != "" && password != "" {
            Auth.auth().signIn(withEmail: email!, password: password!) { [weak self](result, error) in
                self?.indicator.stopAnimating()
                if error == nil {
                    if Auth.auth().currentUser!.isEmailVerified {
                        //go to main page
                        self?.goToMainPage()
                    }else{
                        self?.showMessage(title: "Warning", message: "Your email is not verified")
                    }
                }
                else {
                    
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
            
        }
        alert.addAction(ok)
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func goToMainPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let mainPage = storyboard.instantiateViewController(identifier: "MainPageViewController") as? MainPageViewController {
            mainPage.modalPresentationStyle = .fullScreen
            present(mainPage, animated: true, completion: nil)
        }
    }
    
    @IBAction func backClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
