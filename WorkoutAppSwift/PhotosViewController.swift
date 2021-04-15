//
//  ProgressTrackerViewController.swift
//  WorkoutAppSwift
//
//  Created by Admin on 4/22/18.
//  Copyright © 2018 Emile, Carly B. All rights reserved.
//

import UIKit
import CoreData
import Social

class PhotosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var photoStack: UIStackView!
    
    var imagePicked : UIImageView!
    var photos : [NSManagedObject] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
   
    @IBOutlet weak var trashButton: UIBarButtonItem!
    
    @IBOutlet weak var facebookButton: UIBarButtonItem!
    
    @IBAction func cancelSelection(_ sender: UITapGestureRecognizer) {
        trashButton.isEnabled = false
        facebookButton.isEnabled = false
        imagePicked = nil
    }
    
    @IBAction func gallery(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func deletePhoto(_ sender: Any) {
        let index = imagePicked.tag
        let photo = photos.remove(at: index)
        
        //remove from managed store
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(photo)
        do {
            try managedContext.save()
        } catch {
            print ("Context failed deleting")
        }

        for subview in photoStack.subviews{
            photoStack.removeArrangedSubview(subview)
        }
        
        populateStackView()
        imagePicked = nil
        facebookButton.isEnabled = false
        trashButton.isEnabled = false
    }
    
    @IBAction func shareToFacebook(_ sender: Any) {
        let facebookController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        facebookController?.add(imagePicked.image)
        self.present(facebookController!, animated: true, completion: nil)
        facebookButton.isEnabled = false
        trashButton.isEnabled = false
    }
    
    
    @IBAction func camera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let data = UIImageJPEGRepresentation(image, 1.0)! as NSData
        addImage(image: data)
        dismiss(animated:true, completion: nil)
        
    }
    
    func populateStackView(){
        
        for photo in photos{
        let dateLabel = UILabel()
        dateLabel.text = "\(photo.value(forKey: "date") as! String)"
        dateLabel.backgroundColor = UIColor(red: 0/255.0, green: 48/255.0, blue: 80/255.0, alpha: 1.0)
        dateLabel.textColor = UIColor.white
        dateLabel.textAlignment = .center
        
        let imageView = UIImageView()
        imageView.autoresizingMask = []
        imageView.clipsToBounds = true
        imageView.image = UIImage(data: (photo.value(forKey: "image") as! NSData) as Data)
        let widthConstraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: imageView.superview, attribute: .width, multiplier: 1, constant: 0.0)
        let squareConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 1, constant: 0.0)
        imageView.addConstraints([widthConstraint, squareConstraint])
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.tag = photos.index(of: photo)!
            
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(longPressGesture)
        
        photoStack.addArrangedSubview(dateLabel)
        photoStack.addArrangedSubview(imageView)
        
        dateLabel.leadingAnchor.constraint(equalTo: photoStack.leadingAnchor, constant: 0).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: photoStack.trailingAnchor, constant: 0).isActive = true
        
    }
}
   
    func addImage(image: NSData!){
        //coreData
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //managed photo
        let managedPhoto = NSEntityDescription.entity(forEntityName: "ManagedPhoto", in: managedContext)
        let newManagedPhoto = NSManagedObject(entity: managedPhoto!, insertInto: managedContext)
        newManagedPhoto.setValue(image, forKey: "image")
        newManagedPhoto.setValue(getCurrentDate(), forKey: "date")
        photos.append(newManagedPhoto)
        
        //save photo to store
        do {
            try managedContext.save()
        } catch {
            print ("Context failed saving")
        }
        for subview in photoStack.subviews{
           // photoStack.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        populateStackView()
        
    }
    
    func getCurrentDate()-> String{
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        return formatter.string(from:currentDate)
    }
    
    @objc func selectImage(sender: UILongPressGestureRecognizer){
       let imageView = sender.view as! UIImageView
        imagePicked = imageView
        facebookButton.isEnabled = true
        trashButton.isEnabled = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ManagedPhoto")
        fetchRequest.returnsObjectsAsFaults = false
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            photos = try managedContext.fetch(fetchRequest)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        populateStackView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
