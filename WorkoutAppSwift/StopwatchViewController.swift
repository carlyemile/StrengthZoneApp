//
//  StopwatchViewController.swift
//  WorkoutAppSwift
//
//  Created by Emile, Carly B. on 4/9/18.
//  Copyright © 2018 Emile, Carly B. All rights reserved.
//

import UIKit

class StopwatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var isRunning = false
    var min:Int = 0
    var sec:Int = 0
    var centiSec:Int = 0
    var timer = Timer ()
    var laps: [String] = []
    var numLaps = 0
    
  
    @IBOutlet weak var lapsTableView: UITableView!
    @IBOutlet weak var timeDisplay: UILabel!
    @IBOutlet weak var lapButton: UIButton!
    
    @IBAction func lap(_ sender: Any) {
        if isRunning{
        numLaps += 1
        var minDisplay = "\(min)"
        var secDisplay = "\(sec)"
        var centiSecDisplay = "\(centiSec)"
        if(min<10){
            minDisplay = "0\(min)"
        }
        if(sec<10){
            secDisplay = "0\(sec)"
        }
        if(centiSec<10){
            centiSecDisplay = "0\(centiSec)"
        }
        
        let lapTime = "\(minDisplay):\(secDisplay).\(centiSecDisplay)"
        
        laps.append(lapTime)
        lapsTableView.reloadData()
        
       
            
        }
        
        else{ //reset
            laps.removeAll()
            lapsTableView.reloadData()
        }
        
    }
    
    @IBAction func start(_ sender: UIButton) {
        if(!isRunning){
            isRunning = true
            sender.setTitle("Stop", for: [])
            sender.setTitleColor(UIColor.red, for: .normal)
            lapButton.setTitle("Lap", for: .normal)
            runTimer()
        }
        else{
            isRunning = false
            sender.setTitle("Resume", for: [])
            sender.setTitleColor(UIColor(red: 0/255.0, green: 255/255.0, blue: 146/255.0, alpha: 1.0), for: .normal)
            lapButton.setTitle("Reset", for: .normal)

            timer.invalidate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lapsTableView.delegate = self
        lapsTableView.dataSource = self
        lapsTableView.backgroundView = nil
        lapsTableView.backgroundColor = UIColor.clear        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func timerAction(){
        
        if(centiSec<99){
            centiSec += 1
        }
        else{
            centiSec = 0
        
    
        if (sec<59){
            sec += 1
        }
            
        else{
            sec = 0
            min += 1
        }
        }
        var minDisplay = "\(min)"
        var secDisplay = "\(sec)"
        var centiSecDisplay = "\(centiSec)"
        if(min<10){
            minDisplay = "0\(min)"
        }
        if(sec<10){
            secDisplay = "0\(sec)"
        }
        if(centiSec<10){
            centiSecDisplay = "0\(centiSec)"
        }
        
        timeDisplay.text="\(minDisplay):\(secDisplay).\(centiSecDisplay)"
    }
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: (#selector(RunningTimerViewController.timerAction)), userInfo: nil, repeats: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.lapsTableView.dequeueReusableCell(withIdentifier: "lapCell") as! UITableViewCell
        
        var lapLabel = cell.viewWithTag(2) as? UILabel
        var timeLabel = cell.viewWithTag(3) as? UILabel
        
        lapLabel?.text = "Lap \(indexPath.row+1)"
        timeLabel?.text = "\(self.laps[indexPath.row])"
        return cell
        
    }
    
    }
