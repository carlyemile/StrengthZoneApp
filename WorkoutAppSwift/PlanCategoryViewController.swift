//
//  PlanCategoryViewController.swift
//  WorkoutAppSwift
//
//  Created by Emile, Carly B. on 2/26/18.
//  Copyright © 2018 Emile, Carly B. All rights reserved.
//

import UIKit
import Firebase

class PlanCategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var plansTableView: UITableView!
    var plansRef : DatabaseReference?
    var selectedCategory = ""
    var selectedPlan = ""
    var selectedPlanIndex = 0

    var plans : [String] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plansRef = Database.database().reference().child("plans/\(selectedCategory)")
        plansRef?.observe(.childAdded, with: { snapshot in
             let plan = snapshot.value as! [String: Any]
            self.plans.append(plan["name"] as! String)
            self.plansTableView.reloadData()
            
        })
        plansTableView.delegate = self
        plansTableView.dataSource = self
        plansTableView.backgroundView = nil
        plansTableView.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.isHidden = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPlans(){
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.plansTableView.dequeueReusableCell(withIdentifier: "planCell") as! UITableViewCell
        
        cell.textLabel?.text = self.plans[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlan = plans[indexPath.row]
        selectedPlanIndex = indexPath.row
        self.performSegue(withIdentifier: "goToSelectedPlan", sender: tableView.cellForRow(at: indexPath))
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedPlanVC = segue.destination as? SelectedPlanViewController
        selectedPlanVC?.selectedPlan = selectedPlan
        selectedPlanVC?.selectedPlanIndex = selectedPlanIndex
        selectedPlanVC?.selectedCategory = selectedCategory
        
        self.navigationController?.navigationBar.isHidden = false
    }
}
