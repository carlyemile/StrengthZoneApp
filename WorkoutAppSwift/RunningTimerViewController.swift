//
//  RunningTimerViewController.swift
//  WorkoutAppSwift
//
//  Created by Emile, Carly B. on 2/26/18.
//  Copyright © 2018 Emile, Carly B. All rights reserved.
//

import UIKit
import AVFoundation

class RunningTimerViewController: UIViewController {
   
    var isRunning = false
    var min:Int = 0
    var sec:Int = 0
    var timer = Timer ()
    @IBOutlet weak var timeDisplay: UILabel!
    @IBOutlet weak var startButton: UIButton!
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()

    @IBAction func start(_ sender: UIButton) {
        if(!isRunning){
            isRunning = true
            sender.setTitle("Pause", for: [])
            sender.setTitleColor(UIColor.yellow, for: [])
            runTimer()
        }
        else{
            isRunning = false
            sender.setTitle("Resume", for: [])
            sender.setTitleColor(UIColor(red: 0/255.0, green: 255/255.0, blue: 146/255.0, alpha: 1.0), for: .normal)
            timer.invalidate()
        }
    }
    @IBAction func stop(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        }
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear

 
        
        var minDisplay = "\(min)"
        var secDisplay = "\(sec)"
        if(min<10){
            minDisplay = "0\(min)"
        }
        if(sec<10){
            secDisplay = "0\(sec)"
        }
        timeDisplay.text="\(minDisplay):\(secDisplay)"
        
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
   
    
    @objc func timerAction(){
        
        
        if (sec>0){
            sec-=1
        }
        else{
            min-=1
            sec=59
        }
        var minDisplay = "\(min)"
        var secDisplay = "\(sec)"
        if(min<10){
            minDisplay = "0\(min)"
        }
        if(sec<10){
            secDisplay = "0\(sec)"
        }
        if(sec<=0 && min<=0){
            timer.invalidate();
            startButton.setTitle("Start", for: [])
            startButton.setTitleColor(UIColor(red: 0/255.0, green: 255/255.0, blue: 146/255.0, alpha: 1.0), for: .normal)
            startButton.isEnabled = false
            startButton.isUserInteractionEnabled = false
            isRunning = false
            audioPlayer.play()
            
        }
        
        timeDisplay.text="\(minDisplay):\(secDisplay)"
        
    }
    
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(RunningTimerViewController.timerAction)), userInfo: nil, repeats: true)
        }
    
    
    
    
}
