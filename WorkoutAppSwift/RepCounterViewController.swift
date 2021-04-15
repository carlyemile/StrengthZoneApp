//
//  RepCounterViewController.swift
//  WorkoutAppSwift
//
//  Created by Admin on 4/29/18.
//  Copyright © 2018 Emile, Carly B. All rights reserved.
//

import UIKit
import CoreMotion
import simd

class RepCounterViewController: UIViewController {
  
    @IBOutlet weak var autoView: UIView!
    @IBOutlet weak var manualView: UIView!
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex==0){
            manualView.alpha = 0.0
            autoView.alpha = 1.0
        }
        if(sender.selectedSegmentIndex==1){
            autoView.alpha = 0.0
            manualView.alpha = 1.0
        }    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
  
}
