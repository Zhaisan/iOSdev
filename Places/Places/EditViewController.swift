//
//  EditViewController.swift
//  Places
//
//  Created by Zhaisan on 23/03/2021.
//

import UIKit
import MapKit

protocol changePlace {
    func change(_ title: String, _ subtitle: String)
}

class EditViewController: UIViewController {
    var changeDelegate: changePlace?
    
    var titleStr: String?
    var subtitleStr: String?
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var subtitleTF: UITextField!
    override func viewDidLoad() {
        titleTF.text = titleStr
        subtitleTF.text = subtitleStr
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        
        
    }
    
    @objc func addTapped() {
        
        changeDelegate?.change(titleTF.text!, subtitleTF.text!)
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
    }
    @objc func cancelPressed(sender: UIButton!) {
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
        
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
