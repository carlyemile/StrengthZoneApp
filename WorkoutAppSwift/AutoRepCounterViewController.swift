//
//  AutoRepCounterViewController.swift
//  WorkoutAppSwift
//
//  Created by Admin on 5/5/18.
//  Copyright © 2018 Emile, Carly B. All rights reserved.
//

import UIKit
import AVFoundation

class AutoRepCounterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var countDisplay: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var secPicker: UIPickerView!
    @IBOutlet weak var repPicker: UIPickerView!
    @IBOutlet weak var secPickerLabel: UILabel!
    @IBOutlet weak var repPickerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    var repCount = 0
    var selectedReps = 0
    var pace = 1.0
    var sec = 0.0
    var counterStarted = false
    var timer = Timer()
    var values : [Int] = []
    var isRunning = false
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    
    @IBAction func stop(_ sender: Any) {
       reset()
        
    }
    
    @IBAction func start(_ sender: UIButton) {
    
        if(!counterStarted){
            timer.invalidate()//stop preview
            repCount = 0
            countDisplay.text = "\(repCount)"
            progressBar.progress = 0.0
            sec = 0.0
        }
        counterStarted = true
        //disable and hide views
        instructionsLabel.isHidden = true
        secPicker.isUserInteractionEnabled  = false
        secPickerLabel.isEnabled = false
        repPicker.isUserInteractionEnabled = false
        repPickerLabel.isEnabled = false
        
        if(!isRunning){
            isRunning = true
            sender.setTitle("Stop", for: [])
            sender.setTitleColor(UIColor.red, for: [])
            runTimer()
        }
        else{
            isRunning = false
            sender.setTitle("Resume", for: [])
            sender.setTitleColor(UIColor(red: 0/255.0, green: 255/255.0, blue: 146/255.0, alpha: 1.0), for: .normal)
            timer.invalidate()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secPicker.delegate  = self
        secPicker.dataSource = self
        repPicker.delegate  = self
        repPicker.dataSource = self
        
        

        for index in 1...200{
            values.append(index)
        }
      
        runTimer()

//        // Get the path of the song we want to play
//        do {
//            let audioPath = Bundle.main.path(forResource: "arpeggio", ofType: "mp3")
//            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
//        } catch {
//            print("Error Occurred")
//        }
//        
//        // Add the capability to run the song in the background
//        let audioSession = AVAudioSession.sharedInstance()
//        do {
//            // TODO:  Add background playing of music
//            try audioSession.setCategory(AVAudioSessionCategorySoloAmbient)
//        } catch {
//            print("Error occurred")
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reset(){
        if(isRunning){
            timer.invalidate() // stop timer
            isRunning = false
        }
        instructionsLabel.isHidden = false
        secPicker.isUserInteractionEnabled  = true
        secPickerLabel.isEnabled = true
        repPicker.isUserInteractionEnabled = true
        repPickerLabel.isEnabled = true
        startButton.isUserInteractionEnabled = true
        startButton.isEnabled = true
        startButton.setTitle("Start", for: [])
        startButton.setTitleColor(UIColor(red: 0/255.0, green: 255/255.0, blue: 146/255.0, alpha: 1.0), for: .normal)
        //run preview
        repCount = 0
        sec = 0.0
        counterStarted = false
        runTimer()
        
    }
    
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: (#selector(AutoRepCounterViewController.timerAction)), userInfo: nil, repeats: true)
        
    }
    
    @objc func timerAction(){
        if(!counterStarted){
        pace = Double(values[secPicker.selectedRow(inComponent: 0)])
        if(sec>=pace){
            sec = 0.0
            progressBar.progress = 0.0
            repCount+=1
            if repCount>3 {
                repCount = 1
            }
            
            countDisplay.text = "\(repCount)"
            
        }
       
            sec+=0.5
            progressBar.progress = Float(sec/pace)
        }
        
        else{
            pace = Double(values[secPicker.selectedRow(inComponent: 0)])
            if(sec>=pace){
                sec = 0.0
                progressBar.progress = 0.0
                repCount+=1
                countDisplay.text = "\(repCount)"
            }
            
            sec+=0.5
            progressBar.progress = Float(sec/pace)
            
            if(values[repPicker.selectedRow(inComponent: 0)]>1){ // if user selected reps
            if(repCount>=values[repPicker.selectedRow(inComponent: 0)]){
               
                //play alert sound
              audioPlayer.play()
                
                //stop
                timer.invalidate()
                
                //disable start button to prevent counter from continuing until reset
                startButton.isUserInteractionEnabled = false
                startButton.isEnabled = false
                startButton.setTitle("Start", for: [])
                startButton.setTitleColor(UIColor(red: 0/255.0, green: 255/255.0, blue: 146/255.0, alpha: 1.0), for: .normal)
            }
            }
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
