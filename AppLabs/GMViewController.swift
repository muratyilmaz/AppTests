//
//  GMViewController.swift
//  AppLabs
//
//  Created by test on 09/01/2018.
//  Copyright © 2018 Grey. All rights reserved.
//

import UIKit
import GooglePlaces
import GooglePlacePicker

class GMViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    
    var placesClient: GMSPlacesClient!
    
    var mapView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*mapView = UIView(frame: self.view.bounds )
        mapView.backgroundColor = .black
        view.addSubview(mapView)*/
        
        placesClient = GMSPlacesClient.shared()
    }

    @IBAction func pickPlace(_ sender: Any) {
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        
        addChildViewController(placePicker)
        self.view.addSubview(placePicker.view)
        placePicker.view.frame = self.view.bounds
        placePicker.didMove(toParentViewController: self)
        
        
        //self.present(placePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func getCurrentPlace(_ sender: Any) {
        placesClient.currentPlace { (placeLikelihoodList, error) in
            
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            self.nameLabel.text = "No Current Place"
            self.adressLabel.text = ""
            
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                
                if let place = place {
                    self.nameLabel.text = place.name
                    self.adressLabel.text = place.formattedAddress?.components(separatedBy: ", ").joined(separator: "\n")
                }
            }
        }
    }
    
    func removeViewController(_ viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
    
}

extension GMViewController: GMSPlacePickerViewControllerDelegate {
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
       // self.dismiss(animated: true, completion: nil)
        removeViewController(viewController)
        
        /*print("Place name \(place.name)")
        print("Place address \(place.formattedAddress ?? "no adress")")
        print("Place attributions \(place.attributions)")*/
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
      //  self.dismiss(animated: true, completion: nil)
        removeViewController(viewController)
        print("No place selected")

    }
}
