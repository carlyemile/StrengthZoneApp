//
//  WorkoutPlansViewController.swift
//  WorkoutAppSwift
//
//  Created by Emile, Carly B. on 2/26/18.
//  Copyright © 2018 Emile, Carly B. All rights reserved.
//

import UIKit

class WorkoutPlansViewController: UIViewController {
    
    
    @IBAction func arms(_ sender: UIButton!) {
        super.performSegue(withIdentifier: "goToCategoryView", sender: sender)

    }
    @IBAction func abs(_ sender: UIButton!) {
        super.performSegue(withIdentifier: "goToCategoryView", sender: sender)

    }
    @IBAction func legs(_ sender: UIButton!) {
        super.performSegue(withIdentifier: "goToCategoryView", sender: sender)
    }
  
    @IBAction func fullbody(_ sender: UIButton!) {
        super.performSegue(withIdentifier: "goToCategoryView", sender: sender)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let categoryVC = segue.destination as? WorkoutCategoryViewController
        
            if let buttonTitle = (sender as? UIButton)?.titleLabel?.text {
            categoryVC?.selectedCategory = buttonTitle
            }
            self.navigationController?.navigationBar.isHidden = false
    }

}
