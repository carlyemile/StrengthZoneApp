//
//  CameraViewController.swift
//  WorkoutAppSwift
//
//  Created by Emile, Carly B. on 4/25/18.
//  Copyright © 2018 Emile, Carly B. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBAction func takePicture(_ sender: Any) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        self.imagePicker.cameraCaptureMode = .photo
        self.imagePicker.modalPresentationStyle = .fullScreen
        
        // After we set the properties, we will display the new view controller
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func savePicture(_ sender: Any) {
        //send picture back to previous view
        dismiss(animated: true, completion: nil)
    }
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // This method catches when someone cancels taking a picture
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.contentMode = .scaleToFill
        imageView.image = chosenImage
        dismiss(animated: true, completion: nil)
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
