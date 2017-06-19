//
//  ImageItemControl.swift
//  Abkao
//
//  Created by Inder on 12/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit
import ALCameraViewController

class ImageItemControl: AbstractControl, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var setViewShadow: UIView!
    @IBOutlet weak var txt_ImageURL: UITextField!
    @IBOutlet weak var txt_ProductName: UITextField!
    @IBOutlet weak var txt_ProductPrice: UITextField!    
    @IBOutlet weak var txt_VideoURL: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStartingFields()
    }
    
    func setStartingFields() {
        
        imagePicker.delegate = self
       
        setViewShadow.viewdraw(setViewShadow.bounds)
        txt_ImageURL.addShadowToTextfield()
        txt_ProductName.addShadowToTextfield()
        txt_ProductPrice.addShadowToTextfield()
        txt_VideoURL.addShadowToTextfield()
        
        
    }
    
    
    private func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        dismiss(animated:true, completion: nil) //5
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    
    
    @IBAction func btn_AddImageAction(_ sender: UIButton) {
        
        setImageFromGaleryOrCamera()
        
//        imagePicker.allowsEditing = false
//        imagePicker.sourceType = .photoLibrary
//        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
//        imagePicker.modalPresentationStyle = .popover
//        let presentationController = imagePicker.popoverPresentationController
//        presentationController?.sourceView = sender
//        self.present(imagePicker, animated: true) {}
        
//        imagePicker.allowsEditing = false
//        imagePicker.sourceType = .photoLibrary
//        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
//        
//        if UIDevice.current.userInterfaceIdiom == .phone
//        {
//            present(imagePicker, animated: true, completion: nil)
//        }
//        else
//        {
//            
//            imagePicker.modalPresentationStyle = .popover
//            let presentationController = imagePicker.popoverPresentationController
//            // You must set a sourceView or barButtonItem so that it can
//            // draw a "bubble" with an arrow pointing at the right thing.
//            presentationController?.sourceView = sender
//            self.present(imagePicker, animated: true) {}
//        }
        
    }

    func setImageFromGaleryOrCamera() {
        
        let actionSheetController: UIAlertController = UIAlertController(title: "", message: "Choose An Option!", preferredStyle: .actionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        //Create and add first option action
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Take Picture", style: .default) { action -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
                
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
                
                
            }else{
                
                ShowAlerts.getAlertViewConroller(globleAlert: self, DialogTitle: "Alert", strDialogMessege: "You Have Not Camera Availability")
                
            }
            //Code for launching the camera goes here
        }
        actionSheetController.addAction(takePictureAction)
        //Create and add a second option action
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose From Camera Roll", style: .default) { action -> Void in
            
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .photoLibrary
            
            self.imagePicker.modalPresentationStyle = .popover
            self.imagePicker.popoverPresentationController?.delegate = self as? UIPopoverPresentationControllerDelegate
            self.imagePicker.popoverPresentationController?.sourceView = self.view
            self.imagePicker.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            self.imagePicker.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
            
            let croppingEnabled = true
            let cameraViewController = CameraViewController(croppingEnabled: croppingEnabled) { [weak self] image, asset in
                // Do something with your image here.
                // If cropping is enabled this image will be the cropped version
                
                print(image)
                
                self?.dismiss(animated: true, completion: nil)
            }

            
         
            self.present(cameraViewController, animated: true)
            //self.present(self.imagePicker, animated: true, completion: nil)
            
            //Code for picking from camera roll goes here
        }
        
        actionSheetController.addAction(choosePictureAction)
        
        actionSheetController.popoverPresentationController?.sourceView = view
        actionSheetController.popoverPresentationController?.sourceRect = CGRect(x: view.frame.size.width/2, y: view.bounds.size.height, width: 1.0, height: 1.0)
        
        //Present the AlertController
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    // MARK: - Super Class Method
    
    override var navTitle: String{
        return "Logout"
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

