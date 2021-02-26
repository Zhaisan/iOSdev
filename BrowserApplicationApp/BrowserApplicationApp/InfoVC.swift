//
//  InfoVC.swift
//  BrowserApplicationApp
//
//  Created by Zhaisan on 25.02.2021.
//

import UIKit
import WebKit


struct Lists {
    static var list: [Character] =
        [Character(name: "WildBerries", url: "https://kz.wildberries.ru"),
         Character(name: "Google", url: "https://www.google.ru"),
         Character(name: "Instagram", url: "https://www.instagram.com"),
         Character(name: "GitHub", url: "https://github.com/Zhaisan")]
}

protocol DetailViewDelegate {
    func updateTableViewController()
}

class InfoVC: UIViewController {
    
    @IBOutlet weak var webPage: WKWebView!
    
    var index: Int?
    var delegate: DetailViewDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let ind = index {
            let curUrl = URL(string: (Lists.list[ind].url!))
            let request = URLRequest(url: curUrl!)
            webPage.load(request)

            let tap = UITapGestureRecognizer(target: self, action: #selector(Tapping))
            tap.numberOfTapsRequired = 3
            view.addGestureRecognizer(tap)
        }
        
        setBackColor()
    }
    
    @objc func Tapping() {
        Lists.list[index!].isFavourite = !Lists.list[index!].isFavourite
        setBackColor()
        delegate?.updateTableViewController()
    }
    
    func setBackColor() {
        if let ind = index {
            if Lists.list[ind].isFavourite {
                navigationController?.navigationBar.backgroundColor = .yellow
            }
            else {
                navigationController?.navigationBar.backgroundColor = .white
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

}

