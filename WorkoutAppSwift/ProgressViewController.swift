//
//  ProgressViewController.swift
//  WorkoutAppSwift
//
//  Created by Admin on 5/3/18.
//  Copyright © 2018 Emile, Carly B. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {

    @IBOutlet weak var photosView: UIView!
    @IBOutlet weak var weightView: UIView!
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex==0){
            photosView.alpha = 0.0
            weightView.alpha = 1.0
        }
        if(sender.selectedSegmentIndex==1){
            weightView.alpha = 0.0
            photosView.alpha = 1.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
