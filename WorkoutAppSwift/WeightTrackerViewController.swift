//
//  WeightTrackerViewController.swift
//  WorkoutAppSwift
//
//  Created by Admin on 5/1/18.
//  Copyright © 2018 Emile, Carly B. All rights reserved.
//

import UIKit
import Charts
import CoreData

class WeightTrackerViewController: UIViewController, UIPopoverPresentationControllerDelegate, UITableViewDataSource, UITableViewDelegate, ChartViewDelegate {

    @IBOutlet weak var weightChartView: LineChartView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var dates : [String] = []
    var weights : [Int] = []
    var weightEntries: [NSManagedObject] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var selectedIndex = -1
    
    @IBAction func deleteWeight(_ sender: Any) {
        if(selectedIndex>=0){
            weights.remove(at: selectedIndex)
            dates.remove(at: selectedIndex)
        }
        tableView.reloadData()
        updateGraph()
        
        //delete from store
        let weightEntry = weightEntries[selectedIndex]
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(weightEntry)
        weightEntries.remove(at: selectedIndex)
        do{
            try managedContext.save()
        } catch {
            print("Failed deleting weight")
        }
        
        
        deleteButton.isEnabled = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get core data
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ManagedWeight")
        fetchRequest.returnsObjectsAsFaults = false
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            weightEntries = try managedContext.fetch(fetchRequest)
            
            for entry in weightEntries {
                weights.append((entry.value(forKey: "weight") as? Int)!)

                dates.append((entry.value(forKey: "date") as? String)!)
                
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        weightChartView.delegate = self
        updateGraph()
        
       
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = nil
        tableView.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addWeightPopover" {
            segue.destination.popoverPresentationController?.delegate = self
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    func addWeight(weight: Int){
        weights.append(weight)
        dates.append("\(getCurrentDate())")
        updateGraph()
        tableView.reloadData()
        
        //core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //managed weight
        let managedWeight = NSEntityDescription.entity(forEntityName: "ManagedWeight", in: managedContext)
        let newManagedWeight = NSManagedObject(entity: managedWeight!, insertInto: managedContext)
        newManagedWeight.setValue(weight, forKey: "weight")
        newManagedWeight.setValue(getCurrentDate(), forKey: "date")
        weightEntries.append(newManagedWeight)
        //save weight to store
        do {
            try managedContext.save()
        } catch {
            print ("Context failed saving")
        }
    }
    
    func getCurrentDate()-> String{
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        return formatter.string(from:currentDate)
    }
    
    func updateGraph(){
        weightChartView.noDataText = "No weights have been added."
        weightChartView.noDataTextColor = UIColor.white
        if weights.count > 0{ // prevents empty graph display
        weightChartView.chartDescription?.text = ""
            weightChartView.xAxis.setLabelCount(5, force: true)
        var lineChartEntries = [ChartDataEntry]()
        var weightData : [Int]
        var datesData : [String]
        if weights.count>10{ //only show 10 entries on graph at a time, user can see the rest in table
         weightData = Array(weights[weights.count-11...weights.count-1])
         datesData = Array(dates[dates.count-11...dates.count-1])
        }
        else{
            weightData = weights
            datesData = dates
        }
        
        for i in 0..<weightData.count {
            let chartEntry = ChartDataEntry(x: Double(i), y: Double(weightData[i]), data: datesData as AnyObject)
            lineChartEntries.append(chartEntry)
        }
        
        let chartDataSet = LineChartDataSet(values: lineChartEntries, label: "Weight (lbs)")
        let chartData = LineChartData(dataSet: chartDataSet)
        weightChartView.data = chartData
        weightChartView.data?.setValueTextColor(NSUIColor.white)
        weightChartView.legend.textColor = NSUIColor.white
        weightChartView.xAxis.labelTextColor = NSUIColor.white
        weightChartView.leftAxis.labelTextColor = NSUIColor.white
        weightChartView.rightAxis.drawLabelsEnabled = false
        weightChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: datesData)
        weightChartView.xAxis.granularity = 1
        weightChartView.xAxis.centerAxisLabelsEnabled = true
        
        }
    }
    
    @IBAction func unwindToTracker(segue: UIStoryboardSegue){
        print("unwind")
        let source = segue.source as? AddWeightViewController
        if source?.selectedButton == "Add" { self.addWeight(weight:Int((source?.weightField.text)!)!)
        }
        
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "weightCell") as! UITableViewCell
        
        var weightLabel = cell.viewWithTag(3) as? UILabel
        var dateLabel = cell.viewWithTag(2) as? UILabel
        
       weightLabel?.text = "\(self.weights[indexPath.row]) lbs"
        dateLabel?.text = "\(self.dates[indexPath.row])"
     //   cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        deleteButton.isEnabled = true
    }
    
}
