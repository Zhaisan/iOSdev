//
//  ViewController.swift
//  Places
//
//  Created by Zhaisan on 23/03/2021.
//

import UIKit
import MapKit
import CoreData



class customPin: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    init(pinTitle: String, pinSubtitle: String, location: CLLocationCoordinate2D) {
        self.coordinate = location
        self.title = pinTitle
        self.subtitle = pinSubtitle
    }
}

class ViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource, changePlace {
    func change(_ title: String, _ subtitle: String) {
        let index = places.firstIndex(where: {$0.title == selectedAnnotation?.title && $0.subtitle == selectedAnnotation?.subtitle})!
        let indexInAnn = self.mapView.annotations.firstIndex(where: {$0.title == places[index].title && $0.subtitle == places[index].subtitle})!
        let latt = self.mapView.annotations[indexInAnn].coordinate.latitude
        let long = self.mapView.annotations[indexInAnn].coordinate.longitude
        deleteData(places[index])
        saveData(title, subtitle, latt, long)
        places = loadData()
        showData(places)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = places[indexPath.row].title
        cell.detailTextLabel?.text = places[indexPath.row].subtitle
        
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            deleteData(places[indexPath.row])
            
            places = loadData()
            tableView.reloadData()
            places = loadData()
            showData(places)
        } else if editingStyle == .insert {
            
        }
    }
   
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var navigateView: UIVisualEffectView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var places: [Place] = []
     override func viewDidLoad() {
        
        tableview.separatorColor = .clear
        super.viewDidLoad()
        tableview.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        navigateView.addGestureRecognizer(tap)
        places = loadData()
        showData(places)
        let longPressGestureRecogn = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotation(press:)))
        longPressGestureRecogn.minimumPressDuration = 2.0
        mapView.addGestureRecognizer(longPressGestureRecogn)
        

    }
    
    @IBAction func tableViewPressed(_ sender: UIBarButtonItem) {
        
        if (tableview.isHidden == true) {
            tableview.isHidden = false
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = mapView.bounds
             mapView.addSubview(blurView)
        }else{
            tableview.isHidden = true
            mapView.subviews[mapView.subviews.count - 1].removeFromSuperview()
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.isHidden = true
        mapView.subviews[mapView.subviews.count - 1].removeFromSuperview()
        let index = self.mapView?.annotations.firstIndex(where: {$0.title == places[indexPath.row].title && $0.subtitle == places[indexPath.row].subtitle})!
        self.mapView?.selectAnnotation(self.mapView.annotations[index!], animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    @objc func doubleTapped(tap: UITapGestureRecognizer) {
        if (tap.state == UIGestureRecognizer.State.ended) {
            if (self.mapView?.annotations.count != 0 ){
                let point = tap.location(in: self.view)
                if (point.x > UIScreen.main.bounds.width / 2) {
                    
                    if let selectedAnnotation = selectedAnnotation {
                        //print("ff")
                        let indexInPlaces = places.firstIndex(where: {$0.title == selectedAnnotation.title && $0.subtitle == selectedAnnotation.subtitle})!
                        
                        if (indexInPlaces == places.count - 1) {
                            print(indexInPlaces)
                            let index = self.mapView?.annotations.firstIndex(where: {$0.title == places[0].title && $0.subtitle == places[0].subtitle})!
                            self.mapView?.selectAnnotation(self.mapView.annotations[index!], animated: true)
                        }
                        else {
                            print(indexInPlaces)
                            let index = self.mapView?.annotations.firstIndex(where: {$0.title == places[indexInPlaces+1].title && $0.subtitle == places[indexInPlaces+1].subtitle})!
                            
                            self.mapView?.selectAnnotation(self.mapView.annotations[index!], animated: true)
                        }
                    }
                    
                }
                else{
                    
                    if let selectedAnnotation = selectedAnnotation {
                        
                        let indexInPlaces = places.firstIndex(where: {$0.title == selectedAnnotation.title && $0.subtitle == selectedAnnotation.subtitle})!
                        
                        if (indexInPlaces == 0) {
                            print(indexInPlaces)
                            let index = self.mapView?.annotations.firstIndex(where: {$0.title == places[places.count - 1].title && $0.subtitle == places[places.count - 1].subtitle})!
                            self.mapView?.selectAnnotation(self.mapView.annotations[index!], animated: true)
                        }
                        else {
                            print(indexInPlaces)
                            let index = self.mapView?.annotations.firstIndex(where: {$0.title == places[indexInPlaces-1].title && $0.subtitle == places[indexInPlaces-1].subtitle})!
                            
                            self.mapView?.selectAnnotation(self.mapView.annotations[index!], animated: true)
                        }
                    }
                }
            }
            
            

        }
    }
    var selectedAnnotation: MKPointAnnotation?
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.selectedAnnotation = view.annotation as? MKPointAnnotation
        self.navigationItem.title = selectedAnnotation?.title
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func addAnnotation(press: UILongPressGestureRecognizer){
        if press.state == .began {
            let alert = UIAlertController(title: "Add Place", message: "Fill all the fields", preferredStyle: .alert)
            let loc = press.location(in: mapView)
            let coordinates = mapView.convert(loc, toCoordinateFrom: mapView)
            let saveAction = UIAlertAction(title: "Add", style: .default) { [self]
                (UIAlertAction) in
                let name = alert.textFields?[0].text ?? ""
                let location = alert.textFields?[1].text ?? ""
                self.saveData(name, location, coordinates.latitude, coordinates.longitude)
                self.places = loadData()
                showData(self.places)
               
                

            }
            
            alert.addTextField { (textField) in
                textField.placeholder = "Enter title"
            }
            alert.addTextField { (textField) in
                textField.placeholder = "Enter subtitle"
            }
            alert.addAction(saveAction)
            
            
            present(alert, animated: true, completion: nil)

        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        let annotaionView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
        annotaionView.image = UIImage(named: "pin")
        annotaionView.canShowCallout = true
        
        let btn = UIButton(type: .detailDisclosure)
        annotaionView.rightCalloutAccessoryView = btn
        
        btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return annotaionView
    }
    
    @objc func buttonAction(sender: UIButton!) {
        
        
        let editVC = self.storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        navigationController?.pushViewController(editVC, animated: true)
        editVC.titleStr = selectedAnnotation?.title
        editVC.subtitleStr = selectedAnnotation?.subtitle
        editVC.changeDelegate = self
        print("Button tapped")
    }

    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            break
        }
    }
    func showData(_ places: [Place]) {
        mapView.removeAnnotations(mapView.annotations)
        for place in places {
            
            
           
            let annotation =  MKPointAnnotation()
            annotation.coordinate.latitude = place.latitude
            annotation.coordinate.longitude = place.longitude
            annotation.title = place.title
            annotation.subtitle = place.subtitle
            mapView.addAnnotation(annotation)
            
            self.mapView.delegate = self
            
        }
                
    }
    func loadData() -> [Place] {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<Place>(entityName: "Place")
            do{
                
                try places = context.fetch(fetchRequest)
            }catch{
                print("Hello error! Go away!")
            }
            
        }
        
    
        tableview.reloadData()
        return places
    }
    
    func saveData(_ name: String, _ location: String, _ latitude: Double, _ longitude: Double) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            if let entity = NSEntityDescription.entity(forEntityName: "Place", in: context) {
                let character = NSManagedObject(entity: entity, insertInto: context)
                character.setValue(name, forKey: "title")
                character.setValue(location, forKey: "subtitle")
                character.setValue(latitude, forKey: "latitude")
                character.setValue(longitude, forKey: "longitude")
                do{
                    try context.save()
                    places.append(character as! Place)
                    
                }catch{
                    print("Warning! Error is here!")
                }
                
            }
            
        }
    }
    
    
    
    
    func deleteData(_ object: Place) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            context.delete(object)
            
            do{
                try context.save()
            }
            catch{
                
            }
        }
        
    }
    
    
    
   

}

