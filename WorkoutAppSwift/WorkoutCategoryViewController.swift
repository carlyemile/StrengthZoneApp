//
//  WorkoutCategoryViewController.swift
//  WorkoutAppSwift
//
//  Created by Admin on 5/4/18.
//  Copyright © 2018 Emile, Carly B. All rights reserved.
//

import UIKit

class WorkoutCategoryViewController: UIViewController {
    var selectedCategory = ""
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var plansView: UIView!
    @IBOutlet weak var videosView: UIView!
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex==0){
            videosView.alpha = 0.0
            plansView.alpha = 1.0
        }
        if(sender.selectedSegmentIndex==1){
            plansView.alpha = 0.0
            videosView.alpha = 1.0
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryLabel.text = selectedCategory.uppercased()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedPlans"
        {
            let navController = segue.destination as? UINavigationController
            let categoryVC = navController?.topViewController as! PlanCategoryViewController
            categoryVC.selectedCategory = selectedCategory
            print(categoryVC.selectedCategory)
        }
        
        if segue.identifier == "embedVideos"
        {
            let categoryVC = segue.destination as? CategoryVideoViewController
                categoryVC?.selectedCategory = selectedCategory
            
        }
        self.navigationController?.navigationBar.isHidden = false
    }
}

