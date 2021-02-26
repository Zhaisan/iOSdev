//
//  CharactersVCTableViewController.swift
//  BrowserApplicationApp
//
//  Created by Zhaisan on 25.02.2021.
//

import UIKit

class CharactersVC: UITableViewController, DetailViewDelegate {
    
    var page = false
    
    @IBOutlet weak var mySegmentControl: UISegmentedControl!
    
    private var array: [Character] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.title = "Web Sites"
        array = Lists.list
        

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row].name

        // Configure the cell...

        return cell
    }
    
    var nameWeb: UITextField?
    var urlWeb: UITextField?
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let alertControl = UIAlertController(title: "Add Website", message: nil, preferredStyle: .alert)
        alertControl.addTextField(configurationHandler: nameWeb)
        alertControl.addTextField(configurationHandler: urlWeb)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: self.okay)
        alertControl.addAction(okAction)

        self.present(alertControl, animated: true)
    }
    
    func nameWeb(textField: UITextField) {
        nameWeb = textField
        nameWeb?.placeholder = "Enter title"
    }

    func urlWeb(textField: UITextField) {
        urlWeb = textField
        urlWeb?.placeholder = "Enter url"
    }

    func okay(alert: UIAlertAction) {
        Lists.list.append(Character(name: (nameWeb?.text)!, url: (urlWeb?.text)!))
        updateTableViewController()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let navcon = segue.destination as? UINavigationController,
               let destination = navcon.visibleViewController as? InfoVC,
               let row = tableView.indexPathForSelectedRow?.row {
                destination.index = row
                destination.navigationItem.title = array[row].name
                destination.delegate = self

            }
        }
    }
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        array = segmentIndex()
        tableView.reloadData()
        
    }
    
    func segmentIndex()->[Character] {
        if mySegmentControl.selectedSegmentIndex == 0 {
            return Lists.list
        }
        else{
            return Lists.list.filter{ $0.isFavourite }
        }
    }
    
    func updateTableViewController() {
        array = segmentIndex()
        tableView.reloadData()
    }
    
}
