//
//  MainPageViewController.swift
//  TwitterDemo
//
//  Created by Zhaisan on 11/04/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController( _ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            imageView.image = img
            guard let imgData = img.pngData() else {return}
            storageRef.child("images/\(self.current_user!.uid).png").putData(imgData, metadata: nil, completion: { _,error in
                    guard error == nil
                    else{
                        print("Failed")
                            return}

            })
        }
        picker.dismiss(animated: true, completion: nil)
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    var tweets: [Tweet] = []
    var current_user: User?
    
    @IBOutlet weak var name_label: UILabel!
    @IBOutlet weak var surname_label: UILabel!
    @IBOutlet weak var date_label: UILabel!
    var ref: DatabaseReference!
    @IBOutlet weak var mytableview: UITableView!
    var nameString: String? {
        didSet {
            mytableview.reloadData()
        }
    }
    var surnameStrinf: String?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! customCell
        cell.textView.text = tweets[indexPath.row].content
        cell.email.text = tweets[indexPath.row].author
        cell.name.text = nameString
        cell.surname.text = surnameStrinf
        cell.hashtag.text = "#" + tweets[indexPath.row].hashtag!
        cell.date.text = tweets[indexPath.row].date
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        current_user = Auth.auth().currentUser
        let islandRef = storageRef.child("images/\(current_user!.uid).png")
                islandRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                  if error == nil {
                    let image = UIImage(data: data!)
                    self.imageView.image = image
                    
                  } else {
                    print(error!)
                  }
                }
        
                                          
        
    
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mytableview.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ref = Database.database().reference()
        current_user = Auth.auth().currentUser
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { [self] (snapshot) in
          // Get user value
          let value = snapshot.value as? NSDictionary
            nameString = value?["name"] as? String ?? ""
            name_label.text = nameString
            surnameStrinf = value?["surname"] as? String ?? ""
            surname_label.text = value?["surname"] as? String ?? ""
            date_label.text = value?["date"] as? String ?? ""
          // ...
          }) { (error) in
            print(error.localizedDescription)
        }
        // Do any additional setup after loading the view.
        
        let parent = Database.database().reference().child("tweets")
        parent.observe(.value) { [weak self](snapshot) in
            self?.tweets.removeAll()
            for child in snapshot.children {
                if let snap = child as? DataSnapshot {
                    let tweet = Tweet(snapshot: snap)
                    if(tweet.author == self!.current_user?.email){
                        self?.tweets.append(tweet)
                    }
                    
                }
            }
            self?.tweets.reverse()
            self?.mytableview.reloadData()
        }
        mytableview.rowHeight = 160
        
    }
    
    
    @IBAction func logout(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("Error message")
        }
        let vc = self.storyboard?.instantiateViewController(identifier: "FirstPageViewController") as! FirstPageViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        let usersRef = ref.child("tweets")
//            let queryRef = usersRef.queryOrdered(byChild: "tweet")
//                .queryEqual(toValue: tweets[indexPath.row].content)
//        queryRef.observeSingleEvent(of: .value, with: { (snapshot) in
//
//                for snap in snapshot.children {
//                    let userSnap = snap as! DataSnapshot
//                    let uid = userSnap.key //the uid of each user
//                    let userDict = userSnap.value as! [String:AnyObject]
//                    let timestamp = userDict["tweet"] as! String
//                    self.ref.child("tweets/\(uid)").removeValue()
//                    print("key = \(uid) and timestamp = \(timestamp)")
//                }
//        })
//        tweets.remove(at: indexPath.row)
//        mytableview.reloadData()
//
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let editAction = UIContextualAction(style: .normal, title: "Edit", handler: { (contextualAction, view, boolValue) in
                let alert = UIAlertController(title: "Edit tweet", message: "Enter a text", preferredStyle: .alert)
                
                alert.addTextField { (textField) in
                    textField.text = self.tweets[indexPath.row].content
                }
                
                alert.addTextField { (textField) in
                    textField.text = self.tweets[indexPath.row].hashtag
                }
                
                alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { [weak alert] (_) in
                    let date = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd.MM.yyyy HH:mm"
                    let result = formatter.string(from: date)
                    let content = alert?.textFields![0]
                    let hashtag = alert?.textFields![1]
                    let ref = Database.database().reference()
                    let usersRef = ref.child("tweets")
                    let queryRef = usersRef.queryOrdered(byChild: "tweet").queryEqual(toValue: self.tweets[indexPath.row].content)
                    queryRef.observeSingleEvent(of: .value, with: { (snapshot) in
                        for snap in snapshot.children {
                            let userSnap = snap as! DataSnapshot
                            let uid = userSnap.key
                            print(uid)
                            ref.child("tweets/\(uid)/tweet").setValue(content?.text)
                            ref.child("tweets/\(uid)/date").setValue(result)
                            ref.child("tweets/\(uid)/hashtag").setValue(hashtag?.text)
                        }
                    })
                    
                    self.mytableview.reloadData()
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak alert] (_) in
                    alert?.dismiss(animated: true, completion: nil)
                }))
                
                self.present(alert, animated: true, completion: nil)
            })
            
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: { (contextualAction, view, boolValue) in
                let ref = Database.database().reference()
                let usersRef = ref.child("tweets")
                let queryRef = usersRef.queryOrdered(byChild: "tweet").queryEqual(toValue: self.tweets[indexPath.row].content)
                queryRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    for snap in snapshot.children {
                        let userSnap = snap as! DataSnapshot
                        let uid = userSnap.key
                        ref.child("tweets/\(uid)").removeValue()
                    }
                })
                self.tweets.remove(at: indexPath.row)
                self.mytableview.deleteRows(at: [indexPath], with: .fade)
                self.mytableview.reloadData()
            })
            
            let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
            return swipeActions
        }
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func UploadButton(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    
    
    
    @IBAction func compose(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "New tweet", message: "Enter a text", preferredStyle: .alert)

    
        alert.addTextField { (textField) in
            textField.placeholder = "What's up?"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "hashtag"
        }
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        let result = formatter.string(from: date)
        
        
        alert.addAction(UIAlertAction(title: "Tweet", style: .default, handler: { [self, weak alert] (_) in
            let textField1 = alert?.textFields![0] // Force unwrapping because we know it exists.
            let textField2 = alert?.textFields![1]
            let tweet = Tweet(textField1!.text!, (self.current_user?.email)!, result, textField2!.text!, nameString!, surnameStrinf!)
            
            Database.database().reference().child("tweets").childByAutoId().setValue(tweet.dict)
           
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            
           
        }))

        self.present(alert, animated: true, completion: nil)
    }
    let storageRef = Storage.storage().reference()
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


