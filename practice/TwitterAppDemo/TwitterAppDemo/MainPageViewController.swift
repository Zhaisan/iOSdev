//
//  MainPageViewController.swift
//  TwitterApp
//
//  Created by Zhaisan on 08.04.2021.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var current_user: User?
    @IBOutlet weak var myTableView: UITableView!
    var tweets: [Tweet] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath)
        
        cell.textLabel?.text = tweets[indexPath.row].content
        cell.detailTextLabel?.text = tweets[indexPath.row].author
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        current_user = Auth.auth().currentUser
        // Do any additional setup after loading the view.
        let parent = Database.database().reference().child("tweets")
        parent.observe(.value) { [weak self] (snapshot) in
            self?.tweets.removeAll()
            for child in snapshot.children{
                if let snap = child as? DataSnapshot{
                    let tweet = Tweet(snapshot: snap)
                    self?.tweets.append(tweet)
                }
            }
            self?.tweets.reverse()
            self?.myTableView.reloadData()
        }
    }
    
    
    @IBAction func signout(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
        }
        catch{
            print("Error message")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func compose(_ sender: UIBarButtonItem) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "New tweet", message: "Enter a text", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "What's up?"
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self, weak alert] (_) in
            let textField = alert?.textFields![0]
            
            let tweet = Tweet(textField!.text!, (current_user?.email)!)
            
            Database.database().reference().child("tweets").childByAutoId().setValue(tweet.dict)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
           
            
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
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
