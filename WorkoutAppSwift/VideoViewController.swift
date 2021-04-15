//
//  VideoViewController.swift
//  WorkoutAppSwift
//
//  Created by Admin on 4/21/18.
//  Copyright © 2018 Emile, Carly B. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    @IBAction func arms(_ sender: UIButton!) {
        super.performSegue(withIdentifier: "goToWebView", sender: sender)
    }
    
    @IBAction func abs(_ sender: UIButton!) {
        super.performSegue(withIdentifier: "goToWebView", sender: sender)
    }
    
    @IBAction func legs(_ sender: UIButton!) {
        super.performSegue(withIdentifier: "goToWebView", sender: sender)
    }
    
    @IBAction func fullbody(_ sender: UIButton!) {
        super.performSegue(withIdentifier: "goToWebView", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let categoryVC = segue.destination as? CategoryVideoViewController
        if let buttonTitle = (sender as? UIButton)?.titleLabel?.text {
            categoryVC?.selectedCategory = buttonTitle
        }
        
    }

}
