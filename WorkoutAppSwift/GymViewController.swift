//
//  GymViewController.swift
//  WorkoutAppSwift
//
//  Created by Emile, Carly B. on 2/26/18.
//  Copyright © 2018 Emile, Carly B. All rights reserved.
//

import Foundation
import UIKit
import MapKit


class GymViewController: UIViewController {
    
    var regionRadius: CLLocationDistance = 2500
    var matchingItems: [MKMapItem] = [MKMapItem]()
    @IBOutlet weak var searchTextField: UITextField!
    @IBAction func searchButton(_ sender: Any) {
        let text = String(searchTextField.text!)
        getCoordinate(addressString: text){ coordinate, error in
            guard let coordinate : CLLocationCoordinate2D = coordinate, error == nil else { return }
            let newLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            self.centerMapOnLocation(location: newLocation)
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, self.regionRadius, self.regionRadius)
            self.search(term: "Gym", region: coordinateRegion)
    }
        searchTextField.resignFirstResponder()
    }
    var currentMapType = "Standard"
    @IBAction func mapTypeToggleButton(_ sender: AnyObject) {
        if(currentMapType=="Standard"){
            mapView.mapType = MKMapType.satellite
            sender.setTitle("Standard", for: [])
            currentMapType = "Satelitte"
        }
        else{
            mapView.mapType = MKMapType.standard
            sender.setTitle("Satelitte", for: [])
            currentMapType = "Standard"

        }
    }
    @IBAction func onSliderChanged(_ sender: UISlider) {
        regionRadius = (CLLocationDistance(-sender.value))
        centerMapOnLocation(location:CLLocation(latitude:mapView.region.center.latitude, longitude:mapView.region.center.longitude))
    }
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Lets show the user's location..
        mapView.showsUserLocation = true
       
            getCoordinate(addressString: "Hamden, CT"){ coordinate, error in
            guard let coordinate = coordinate, error == nil else { return }
                let initialLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                self.centerMapOnLocation(location: initialLocation)
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, self.regionRadius, self.regionRadius)
                self.search(term: "Gym", region: coordinateRegion)

           
        }
         }
    
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated:true)
      //  print("Desired",coordinateRegion.center.latitude)
       // print("Resulting",mapView.region.center.latitude)
    }
    
    func getCoordinate( addressString : String, completionHandler: @escaping(CLLocationCoordinate2D?, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
    
    func search(term: String?, region: MKCoordinateRegion){
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = term
        searchRequest.region = region
        
        
        let search = MKLocalSearch(request: searchRequest)
        
        //Execute the search as a seperate thread
        search.start(completionHandler : {(response, error) in
            if error != nil {
                //There was an error searching..
            }
            else if response!.mapItems.count == 0 {
                //If nothing gets returned..
            }
            else{
                for item in response!.mapItems {
                    self.matchingItems.append(item as MKMapItem)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    self.mapView.addAnnotation(annotation)
                }//closes the for loop
            }//closes the if
            
        })//closes the completion handler
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
