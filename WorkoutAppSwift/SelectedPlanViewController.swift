//
//  SelectedPlanViewController.swift
//  WorkoutAppSwift
//
//  Created by Admin on 5/5/18.
//  Copyright © 2018 Emile, Carly B. All rights reserved.
//

import UIKit
import Firebase

class SelectedPlanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var selectedCategory = ""
    var selectedPlan = ""
    var selectedPlanIndex = 0
    var exercises : [String] = []
    var durationsForExercise : [String] = []
    var exercisesRef : DatabaseReference?
    @IBOutlet weak var planLabel: UILabel!
    @IBOutlet weak var exerciseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exercisesRef = Database.database().reference().child("plans/\(selectedCategory)/\(selectedPlanIndex)/exercises")
        exercisesRef?.observe(.childAdded, with: { snapshot in
            let exercise = snapshot.value as! [String: Any]
            self.exercises.append(exercise["name"] as! String)
            self.durationsForExercise.append(exercise["duration"] as! String)
            self.exerciseTableView.reloadData()
            
        })
        exerciseTableView.dataSource = self
        exerciseTableView.delegate = self
        exerciseTableView.backgroundView = nil
        exerciseTableView.backgroundColor = UIColor.clear
        planLabel.text = selectedPlan
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.exerciseTableView.dequeueReusableCell(withIdentifier: "exerciseCell") as! UITableViewCell
        
        var exerciseLabel = cell.viewWithTag(2) as? UILabel
        var durationLabel = cell.viewWithTag(3) as? UILabel
        
        exerciseLabel?.text = "\(exercises[indexPath.row])"
        durationLabel?.text = "\(durationsForExercise[indexPath.row])"
        
        return cell
        
    }
    
    
}
