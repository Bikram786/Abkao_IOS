//
//  ImageItemControl.swift
//  Abkao
//
//  Created by Inder on 12/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit
import ALCameraViewController
import SVProgressHUD

class ImageItemControl: AbstractControl, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    
    var getPreviousProducts = ProductDescI()
    var status:String?
    let imagePicker = UIImagePickerController()
    var sendFinalImage = ""
    
    @IBOutlet weak var setViewShadow: UIView!
    @IBOutlet weak var imageView: UIView!
    
    @IBOutlet weak var txt_ProductName: UITextField!
    @IBOutlet weak var txt_ProductPrice: UITextField!
    @IBOutlet weak var txt_VideoURL: UITextField!
    @IBOutlet weak var setupImage: UIImageView!
    
    @IBOutlet weak var btn_Save: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStartingFields()
        SVProgressHUD.setMinimumDismissTimeInterval(0.01)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        
        
//        let value = UIInterfaceOrientation.landscapeLeft.rawValue
//        UIDevice.current.setValue(value, forKey: "orientation")
       

    }
    
    
    // MARK: - Super Class Method
    
    override var navTitle: String{
        return "Logout"
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        return .landscape
    }
    
    
    
    override var shouldAutorotate: Bool {
        
        return false
    }
    
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        
        return .landscapeRight
    }
    
    
    func setStartingFields() {
        
        if status == "edit"{
            txt_ProductName.text = getPreviousProducts.productName!
            txt_ProductPrice.text = getPreviousProducts.productPrice!
            txt_VideoURL.text = getPreviousProducts.productVedUrl!
            let url = URL(string: getPreviousProducts.productImgUrl!)
            setupImage.af_setImage(withURL: url!)
            btn_Save.setTitle("Update", for: .normal)
            
        }else{
            btn_Save.setTitle("Save", for: .normal)
        }
        
        imagePicker.delegate = self
        setViewShadow.viewdraw(setViewShadow.bounds)
        imageView.setViewBoarder()
        txt_ProductName.addShadowToTextfield()
        txt_ProductPrice.addShadowToTextfield()
        txt_VideoURL.addShadowToTextfield()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlurButton(_:)))
        setViewShadow.addGestureRecognizer(tapGesture)
    }
    
    func tapBlurButton(_ sender: UITapGestureRecognizer) {
        
        setImageFromGaleryOrCamera()
    }
    
    @IBAction func btn_SaveAction(_ sender: UIButton) {
        
        guard let productName = txt_ProductName.text, productName != "" else {
            
            SVProgressHUD.showError(withStatus: "Please enter product name")
            
            return
        }
        
        guard let productPrice = txt_ProductPrice.text, productPrice != "" else {
            
            SVProgressHUD.showError(withStatus: "Please enter product price")
            
            return
        }
       
         if(!(self.verifyUrl(urlString: txt_VideoURL.text)))
        {
            ShowAlerts.getAlertViewConroller(globleAlert: self, DialogTitle: "Alert", strDialogMessege: "Enter correct video URL")
            return
        }
        
        var  dictData : [String : Any] =  [String : Any]()
        dictData["product_name"] = txt_ProductName.text!
        dictData["product_price"] = txt_ProductPrice.text!
        dictData["product_video_url"] = txt_VideoURL.text
        
        var  imageDictData : [String : Any] =  [String : Any]()
        dictData["userid"] = ModelManager.sharedInstance.profileManager.userObj?.userID
        
        if status == "edit"{
            
            dictData["product_id"] = getPreviousProducts.productID!
            
            if sendFinalImage != "" {
                imageDictData["mimetype"] = "image/jpeg"
            }else{
                imageDictData["mimetype"] = ""
            }
            imageDictData["filecontent"] = sendFinalImage
            dictData["fileUpload"] = imageDictData
            
            
            print("Image update dictdata : \(dictData)")
            SVProgressHUD.show(withStatus: "Loading.....")
            
            ModelManager.sharedInstance.imageCellManager.updateRecord(userInfo: dictData) { (productObj, isSuccess, strMessage) in
                SVProgressHUD.dismiss()
                if(isSuccess){
                    
                    self.getPreviousProducts.productID = productObj?.productID
                    self.getPreviousProducts.productName = productObj?.productName
                    self.getPreviousProducts.productImgUrl = productObj?.productImgUrl
                    self.getPreviousProducts.productPrice = productObj?.productPrice
                    self.getPreviousProducts.productVedUrl = productObj?.productVedUrl
                    
                    SVProgressHUD.showError(withStatus: strMessage)
                    _ = self.navigationController?.popViewController(animated: true)
                }else{
                    SVProgressHUD.showError(withStatus: strMessage)
                }
                
            }
        }else{
            
            if sendFinalImage != "" {
                imageDictData["mimetype"] = "image/jpeg"
            }else{
                imageDictData["mimetype"] = ""
            }
            imageDictData["filecontent"] = sendFinalImage
            dictData["fileUpload"] = imageDictData
            
            SVProgressHUD.show(withStatus: "Loading.....")
            
            ModelManager.sharedInstance.imageCellManager.addNewRecord(userInfo: dictData) { (productPriceObj, isSuccess, strMessage) in
                SVProgressHUD.dismiss()
                if(isSuccess){
                    SVProgressHUD.showError(withStatus: strMessage)
                    _ = self.navigationController?.popViewController(animated: true)
                }else{
                    SVProgressHUD.showError(withStatus: strMessage)
                }
                
            }
        }
        
        
        
    }
    
    
    func setImageFromGaleryOrCamera() {
        
//        let actionSheetController: UIAlertController = UIAlertController(title: "", message: "Choose An Option!", preferredStyle: .actionSheet)
//        
//        //Create and add the Cancel action
//        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
//            //Just dismiss the action sheet
//        }
//        actionSheetController.addAction(cancelAction)
//        
//        //Create and add a second option action
//        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Upload Picture", style: .default) { action -> Void in
        
//            self.imagePicker.allowsEditing = true
//            self.imagePicker.sourceType = .photoLibrary
//            
//            self.imagePicker.modalPresentationStyle = .popover
//            self.imagePicker.popoverPresentationController?.delegate = self as? UIPopoverPresentationControllerDelegate
//            self.imagePicker.popoverPresentationController?.sourceView = self.view
            //self.imagePicker.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            //self.imagePicker.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
            
            let croppingEnabled = true
        
            let cameraViewController = CameraViewController(croppingEnabled: croppingEnabled) { [weak self] image, asset in
                // Do something with your image here.
                // If cropping is enabled this image will be the cropped version
                
                
                if image != nil {
                    let getImage = self?.resizeImage(image: image!, newWidth: 500)
                    self?.setupImage.image = getImage
                    let imageData = UIImageJPEGRepresentation(getImage!, 0.2)
                    self?.sendFinalImage = (imageData?.base64EncodedString(options: .endLineWithLineFeed))!
                }
                
               
                self?.dismiss(animated: true, completion: nil)
            }
        
        
            
            
            self.present(cameraViewController, animated: true)
            //self.present(self.imagePicker, animated: true, completion: nil)
            
            //Code for picking from camera roll goes here
        //}
        
//        actionSheetController.addAction(choosePictureAction)
//        
//        actionSheetController.popoverPresentationController?.sourceView = view
//        actionSheetController.popoverPresentationController?.sourceRect = CGRect(x: view.frame.size.width/2, y: view.bounds.size.height, width: 1.0, height: 1.0)
        
        //Present the AlertController
        //self.present(actionSheetController, animated: true, completion: nil)
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

