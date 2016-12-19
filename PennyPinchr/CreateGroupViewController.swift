//
//  CreateGroupViewController.swift
//  PennyPinchr
//
//  Created by Matt Maher on 12/15/16.
//  Copyright © 2016 MMMD. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    
    var isFromAuth = false
    
    var userName = ""
    var email = ""
    var imageToSave: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addImageTapped(_:)))
        userImageView.addGestureRecognizer(tapGesture)
        userImageView.isUserInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addImageTapped(_ sender: UITapGestureRecognizer) {
        var imageSource = ""
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            imageSource = "camera"
        }
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            if imageSource == "camera" {
                imageSource = "both"
            } else {
                imageSource = "library"
            }
        }
        
        imageSourceAlert(source: imageSource)
    }
    
    func imageSourceAlert(source: String) {
        
        if source == "both" {
            let alertController = UIAlertController(title: "Profile Image", message: "Would you like to take a new picture or use one from your Image Library?", preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                
            }
            alertController.addAction(cancelAction)
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                self.accessCamera()
            }
            alertController.addAction(cameraAction)
            
            let libraryAction = UIAlertAction(title: "Library", style: .default) { (action) in
                self.accessPhotoLibrary()                }
            alertController.addAction(libraryAction)
            
            self.present(alertController, animated: true) {
                
            }
        } else if source == "camera" {
            accessCamera()
        } else if source == "library" {
            accessPhotoLibrary()
        }
    }
    
    func accessCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
        imagePicker.allowsEditing = true
        
        self.present(imagePicker, animated: true, completion: { _ in })
    }
    
    func accessPhotoLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
        imagePicker.allowsEditing = true
        
        self.present(imagePicker, animated: true, completion: { _ in })
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            userImageView.image = image
            let imageData = UIImageJPEGRepresentation(userImageView.image!, 0.6)
            
            imageToSave = UIImage(data: imageData!)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveUserTapped(_ sender: Any) {
        if imageToSave != nil && nameField.text != "" {
            if isFromAuth {
                completeSaveAuth()
            } else {
                completeSave()
            }
        } else {
            let alertController = UIAlertController(title: "Profile Info", message: "Please enter a name and an image to complete the profile.", preferredStyle: .actionSheet)
            
            let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                
            }
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true) {
                
            }
        }
    }
    
    func completeSave() {
        DataService.ds.saveUserGroup(groupName: nameField.text!) {
            (result: String) in
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func completeSaveAuth() {
        DataService.ds.completeAccount(email: email, name: userName, image: imageToSave!, groupName: nameField.text!) {
            (result: String) in
            
            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
