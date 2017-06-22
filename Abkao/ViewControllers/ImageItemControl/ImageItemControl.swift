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
    var sendFinalImage = ""
    
    @IBOutlet weak var setViewShadow: UIView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var txt_ProductName: UITextField!
    @IBOutlet weak var txt_ProductPrice: UITextField!    
    @IBOutlet weak var txt_VideoURL: UITextField!
    @IBOutlet weak var setupImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStartingFields()
    }
    
    // MARK: - Super Class Method
    
    override var navTitle: String{
        return "Logout"
    }
    
    
    func setStartingFields() {
        
        imagePicker.delegate = self
        setViewShadow.viewdraw(setViewShadow.bounds)
        imageView.setViewBoarder()
        txt_ProductName.addShadowToTextfield()
        txt_ProductPrice.addShadowToTextfield()
        txt_VideoURL.addShadowToTextfield()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        setViewShadow.addGestureRecognizer(tapGesture)
    }
    
    
//    private func imagePickerController(_ picker: UIImagePickerController,
//                               didFinishPickingMediaWithInfo info: [String : AnyObject])
//    {
//        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
//        dismiss(animated:true, completion: nil) //5
//    }
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }

    func tapBlurButton(_ sender: UITapGestureRecognizer) {
        
        setImageFromGaleryOrCamera()
    }
    
    @IBAction func btn_SaveAction(_ sender: UIButton) {
        
        var  dictData : [String : Any] =  [String : Any]()
        dictData["product_name"] = "Guru 12"
        dictData["product_price"] = "20"
        dictData["product_video_url"] = "https://www.youtube.com/watch?v=5ahMQwxN9Js"        
        var  imageDictData : [String : Any] =  [String : Any]()
        imageDictData["mimetype"] = "image/jpeg"
        imageDictData["filecontent"] = sendFinalImage
        dictData["fileUpload"] = imageDictData
        dictData["userid"] = "5"
        
        print(dictData)
        
        ModelManager.sharedInstance.imageCellManager.addNewRecord(userInfo: dictData) { (userObj, isSuccess, strMessage) in
            
            if(isSuccess)
            {
                
                _ = self.navigationController?.popViewController(animated: true)
            }
            
        }

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
                
                let getImage = self?.resizeImage(image: image!, newWidth: 300)
                self?.setupImage.image = getImage
                let imageData = UIImageJPEGRepresentation(getImage!, 0.2)
                self?.sendFinalImage = (imageData?.base64EncodedString(options: .endLineWithLineFeed))!                
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
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
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

