//
//  AddWeightViewController.swift
//  WorkoutAppSwift
//
//  Created by Admin on 5/5/18.
//  Copyright © 2018 Emile, Carly B. All rights reserved.
//

import UIKit

class AddWeightViewController: UIViewController {

    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var weightStepperValue: UIStepper!
    var selectedButton = ""
    
    @IBAction func weightCheck(_ sender: UITextField) {
        if Int(sender.text!)! > 2000 {
        sender.text = "2000"
            weightStepperValue.value = 2000
        }
    }
   
    @IBAction func weightStepper(_ sender: UIStepper) {
        weightField.text = Int(sender.value).description
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        selectedButton = sender.title!
self.performSegue(withIdentifier: "unwindToTracker", sender: sender)
        
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
       
        selectedButton = sender.title!
        self.performSegue(withIdentifier: "unwindToTracker", sender: sender)
        /**
       let prevVC = presentingViewController as? WeightTrackerViewController
        
        prevVC?.addWeight(weight: Int(weightField.text!)!)
        print("added")
        print(prevVC?.dates)
        dismiss(animated: true, completion: nil)
 **/
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weightField.text="200"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
