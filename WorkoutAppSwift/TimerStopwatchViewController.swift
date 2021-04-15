//
//  TimerStopwatchViewController.swift
//  WorkoutAppSwift
//
//  Created by Admin on 5/5/18.
//  Copyright © 2018 Emile, Carly B. All rights reserved.
//

import UIKit

class TimerStopwatchViewController: UIViewController {

    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var stopwatchView: UIView!
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex==0){
            stopwatchView.alpha = 0.0
            timerView.alpha = 1.0
        }
        if(sender.selectedSegmentIndex==1){
            timerView.alpha = 0.0
            stopwatchView.alpha = 1.0
        }    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
