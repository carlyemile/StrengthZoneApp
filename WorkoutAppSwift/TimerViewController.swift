//
//  TimerViewController.swift
//  WorkoutAppSwift
//
//  Created by Emile, Carly B. on 2/26/18.
//  Copyright © 2018 Emile, Carly B. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
   
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex==1){
            performSegue(withIdentifier: "goToStopwatch", sender: sender)
        }
    }
    
    
    @IBOutlet weak var minPicker: UIPickerView!
    @IBOutlet weak var secPicker: UIPickerView!
    
    
    var values: [NSInteger] = []

    @IBAction func startTimer(_ sender: Any) {
        if(!(values[secPicker.selectedRow(inComponent: 0)]==0 && values[minPicker.selectedRow(inComponent: 0)]==0)){ //if user did not select both 0s
            performSegue(withIdentifier: "goToRunningTimer", sender: sender)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.isHidden = true
        
        minPicker.delegate = self
        minPicker.dataSource = self
        
        secPicker.delegate = self
        secPicker.dataSource = self
        
        for index in 0...59{
            values.append(index)
        }
    }
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return values.count
        }
        
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
         return NSMutableAttributedString(string: "\(values[row])", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is RunningTimerViewController{
            let runningTimer = segue.destination as? RunningTimerViewController
            runningTimer?.min = values[minPicker.selectedRow(inComponent: 0)]
            runningTimer?.sec = values[secPicker.selectedRow(inComponent: 0)]
            self.navigationController?.navigationBar.isHidden = false
            
        }
    }

}
