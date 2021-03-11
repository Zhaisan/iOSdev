//
//  ViewController.swift
//  KBTUinformerApp
//
//  Created by Zhaisan on 11.03.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var faculties = [Faculty.init("ISE", "International School of Economics", UIImage.init(named: "economic")!),
                     Faculty.init("KMA", "Kazakhstan Maritime Academy", UIImage.init(named: "ship")!),
                     Faculty.init("FIT", "Faculty of Informational Technologies", UIImage.init(named: "fit")!),
                     Faculty.init("BS", "Business School", UIImage.init(named: "money")!),
                     Faculty.init("FEOGI", "Faculty of Energy and Oil & Gas Industry", UIImage.init(named: "gas")!),
                     Faculty.init("SCE", "School of Chemical Engineering", UIImage.init(named: "chemistry")!),
                     Faculty.init("SMC", "School of Mathematics and Cybernetics", UIImage.init(named: "math")!)]
    
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faculties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as? CustomCell
                
        cell?.facultyName.text = faculties[indexPath.row].fac_name
        cell?.facultyDesc.text = faculties[indexPath.row].description
        cell?.facultyImageView.image = faculties[indexPath.row].image
                
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        myTableView.deselectRow(at: indexPath, animated: true)
    }
     
    @IBOutlet weak var myTableView: UITableView!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

