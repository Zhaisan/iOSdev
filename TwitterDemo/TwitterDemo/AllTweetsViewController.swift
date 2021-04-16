//
//  MainPageViewController.swift
//  TwitterDemo
//
//  Created by Zhaisan on 11/04/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AllTweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var tweets: [Tweet] = []
    var searchTweet: [Tweet] = []
    var searching = false
    @IBOutlet weak var searchBar: UISearchBar!
    var ref: DatabaseReference!
    var current_user: User?
    @IBOutlet weak var mytableview: UITableView!
    var nameString: String? {
        didSet {
            mytableview.reloadData()
        }
    }
    var surnameStrinf: String?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchTweet.count
        }
        return tweets.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell2", for: indexPath) as! customCell
        if searching {
            cell.textView.text = searchTweet[indexPath.row].content
            cell.email.text = searchTweet[indexPath.row].author
            cell.name.text = searchTweet[indexPath.row].name
            cell.surname.text = searchTweet[indexPath.row].surname
            cell.hashtag.text = "#" + searchTweet[indexPath.row].hashtag!
            cell.date.text = searchTweet[indexPath.row].date
        }else{
            cell.textView.text = tweets[indexPath.row].content
            cell.email.text = tweets[indexPath.row].author
            cell.name.text = tweets[indexPath.row].name
            cell.surname.text = tweets[indexPath.row].surname
            cell.hashtag.text = "#" + tweets[indexPath.row].hashtag!
            cell.date.text = tweets[indexPath.row].date
        }
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        

        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mytableview.deselectRow(at: indexPath, animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        mytableview.reloadData()
        current_user = Auth.auth().currentUser
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { [self] (snapshot) in
          // Get user value
          let value = snapshot.value as? NSDictionary
            nameString = value?["name"] as? String ?? ""
            surnameStrinf = value?["surname"] as? String ?? ""
            
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
                    print(tweet.name as Any)
                    self?.tweets.append(tweet)
                }
            }
            self?.tweets.reverse()
            self?.mytableview.reloadData()
        }
        mytableview.rowHeight = 160
        
    }
    
    
    
    @IBAction func acc(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTweet.removeAll()
        
        for tweet in tweets {
            print(searchText.lowercased())
            if (((tweet.hashtag?.lowercased().range(of: searchText.lowercased()))) != nil) {
                    searchTweet.append(tweet)
                }
            }
        searching = true
        if searchText == "" {
            searching = false;
        }
        mytableview.reloadData()
        
        
    
        
        
    }

}


