//
//  ManualRepCounterViewController.swift
//  WorkoutAppSwift
//
//  Created by Admin on 5/5/18.
//  Copyright © 2018 Emile, Carly B. All rights reserved.
//

import UIKit
import AVFoundation

class ManualRepCounterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    

    @IBOutlet weak var countDisplay: UILabel!
    @IBOutlet weak var preInstructions: UILabel!
    @IBOutlet weak var repPicker: UIPickerView!
    @IBOutlet weak var repsTitle: UILabel!
    @IBOutlet weak var postInstructions: UILabel!
    @IBOutlet weak var startButton: UIButton!
   
    
    var values : [Int] = []
    var counterStarted = false
    var repCount = 0
    var selectedReps = 0
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()

    @IBAction func start(_ sender: UIButton) {
        sender.isHidden = true
        sender.isUserInteractionEnabled = false
        preInstructions.isHidden = true
        repPicker.isHidden = true
        repPicker.isUserInteractionEnabled = false
        repsTitle.isHidden = true
        postInstructions.isHidden = false
        counterStarted = true
    }
    
    //tap to count reps
    @IBAction func countRep(_ sender: Any) {
        if(counterStarted){
            repCount+=1
            countDisplay.text = "\(repCount)"
            if repPicker.selectedRow(inComponent: 0)>1{ //if user selected reps
            if(repCount==values[repPicker.selectedRow(inComponent: 0)]){
                //alert user
                counterStarted = false
                postInstructions.text = "Swipe up to reset counter."
                //play alert sound
                audioPlayer.play()
            }
            else{
       
            }
            }
        }
        
    }
    
    //swipe up to stop counter
    @IBAction func stopCounting(_ sender: Any) {
        startButton.isHidden = false
        startButton.isUserInteractionEnabled = true
        preInstructions.isHidden = false
        repPicker.isHidden = false
        repPicker.isUserInteractionEnabled = true
        repsTitle.isHidden = false
        postInstructions.isHidden = true
        repCount = 0
        countDisplay.text = "\(repCount)"
        counterStarted = false
        postInstructions.text = "Tap the screen to count a rep or swipe up to stop counting."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repPicker.delegate = self
        repPicker.dataSource = self

        for index in 1...200{
            values.append(index)
        }
        
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
