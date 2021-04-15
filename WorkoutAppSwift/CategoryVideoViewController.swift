//
//  CategoryVideoViewController.swift
//  WorkoutAppSwift
//
//  Created by Admin on 4/21/18.
//  Copyright © 2018 Emile, Carly B. All rights reserved.
//

import UIKit
import WebKit

class CategoryVideoViewController: UIViewController, WKUIDelegate{

    @IBOutlet var webKitView: WKWebView!
    var selectedCategory = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webKitView.uiDelegate = self
        
        var url:String
        if(selectedCategory=="Abs"){
        url = "https://www.youtube.com/playlist?list=PLr5TAC6fJo8AATmDq_0AKRTzaDDM7wqMy"
        }
        
        else if(selectedCategory=="Legs"){
            url = "https://www.youtube.com/playlist?list=PLr5TAC6fJo8BIdrCeWX4GQT8ft9Rn4Qo1"
        }
        
        else if(selectedCategory=="Arms"){
            url = "https://www.youtube.com/playlist?list=PLr5TAC6fJo8CXTEyU2E1hTThBXBn0CP0g"
        }
        
        else{
            url = "https://www.youtube.com/playlist?list=PLr5TAC6fJo8Dtm7xHs3YveExCiNNc-wTK"
        }
        let webURL = URL(string: url)
        let urlRequest = URLRequest(url: webURL!)
        webKitView.load(urlRequest)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
