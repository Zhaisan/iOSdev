//
//  LoginViewController.swift
//  TwitterApp
//
//  Created by Zhaisan on 08.04.2021.
//

import UIKit
import Firebase
import FirebaseAuth
class LoginViewController: UIViewController {
    
    var current_user: User?
    @IBOutlet weak var email_field: UITextField!
    
    @IBOutlet weak var password_field: UITextField!
    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        current_user = Auth.auth().currentUser
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        current_user = Auth.auth().currentUser
        if current_user != nil && current_user!.isEmailVerified{
            gotoMainPage()
        }
    }
    
    @IBAction func login_clicked(_ sender: UIButton) {
        let email = email_field.text
        let password = password_field.text
        indicator.startAnimating()
        if email != "" && password != ""{
            
            Auth.auth().signIn(withEmail: email!, password: password!) {
                [weak self] (result, error) in
                self?.indicator.stopAnimating()
                if error == nil{
                    if Auth.auth().currentUser!.isEmailVerified{
                        // going to main page
                        self?.gotoMainPage()
                    }else{
                        self?.showMessage(title: "Warning", message: "Your email is not verified")
                    }
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
            
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    func gotoMainPage(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let mainPage = storyboard.instantiateViewController(identifier: "MainPageViewController") as? MainPageViewController{
            mainPage.modalPresentationStyle = .fullScreen
            present(mainPage, animated: true, completion: nil)
        }
    }

}
