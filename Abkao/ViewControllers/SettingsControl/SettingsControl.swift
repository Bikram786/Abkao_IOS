//
//  SettingsControl.swift
//  Abkao
//
//  Created by Inder on 11/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit
import SVProgressHUD

import ChromaColorPicker

class SettingsControl: AbstractControl,ChromaColorPickerDelegate {

    @IBOutlet weak var viewColorPicker: UIView!
    
    @IBOutlet weak var btn_Camera: UIButton!
    
    @IBOutlet weak var btnSelectColor: UIButton!
    
    var selectedBgColorHex : String = (ModelManager.sharedInstance.settingsManager.settingObj?.backGroundColor)!
    
    var setGridRows:Int?
    var setPriceRows:Int?
    
     @IBOutlet weak var setViewShadow: UIView!
     @IBOutlet weak var txt_DefaultURL: UITextField!
    @IBOutlet weak var setImageGrid: UISegmentedControl!
    @IBOutlet weak var setPriceGrid: UISegmentedControl!
    @IBOutlet weak var lbl_AccountNo: UILabel!
    
    @IBOutlet weak var lbl_AccountName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set ColorPicker Delegate
        
        let neatColorPicker = ChromaColorPicker(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        neatColorPicker.delegate = self
        neatColorPicker.padding = 5
        neatColorPicker.stroke = 5
        
        neatColorPicker.hexLabel.textColor = UIColor.red
        
        viewColorPicker.addSubview(neatColorPicker)
        
        btn_Camera.isHidden = true
        setViewShadow.viewdraw(setViewShadow.bounds)
        
        setGridRows = ModelManager.sharedInstance.settingsManager.settingObj?.imageGridRow
        setPriceRows = ModelManager.sharedInstance.settingsManager.settingObj?.priceGridDimention
        self.txt_DefaultURL.text = ModelManager.sharedInstance.settingsManager.settingObj?.videoURL
        
        //Text color for segments
        let titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        setImageGrid.setTitleTextAttributes(titleTextAttributes, for: .normal)
        setPriceGrid.setTitleTextAttributes(titleTextAttributes, for: .normal)
        setImageGrid.setTitleTextAttributes(titleTextAttributes, for: .selected)
        setPriceGrid.setTitleTextAttributes(titleTextAttributes, for: .selected)        
        SVProgressHUD.setMinimumDismissTimeInterval(0.01)
        callProductAPI()
        
    }
    
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor)
    {
        let hexString = color.toHexString
        
        selectedBgColorHex = hexString
        print(hexString)
        
        btnSelectColor.backgroundColor = color
        viewColorPicker.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super .viewWillAppear(true)
        
        viewColorPicker.isHidden = true
    }
    

    // MARK: - Super Class Method
    
    override var navTitle: String{
        return "Logout"
    }
    
    func saveSetting(){
        
        
        guard let vedURL = txt_DefaultURL.text, vedURL != "" else
        {
            ShowAlerts.getAlertViewConroller(globleAlert: self, DialogTitle: "Alert", strDialogMessege: "Enter default video URL")
            return
        }
        
        if(!(self.verifyUrl(urlString: txt_DefaultURL.text!)))
        {
            ShowAlerts.getAlertViewConroller(globleAlert: self, DialogTitle: "Alert", strDialogMessege: "Enter correct video URL")
            return
        }
        
        var  dictData : [String : Any] =  [String : Any]()
        dictData["userid"] = ModelManager.sharedInstance.profileManager.userObj?.userID
        dictData["price_grid_dimension"] = String(describing: self.setPriceRows!)
        dictData["image_grid_row"] = String(describing: self.setGridRows!)
        dictData["video_url"] = self.txt_DefaultURL.text!
        dictData["backgroundColor"] = self.selectedBgColorHex
        
        SVProgressHUD.show(withStatus: "Loading.....")
        ModelManager.sharedInstance.settingsManager.updateSetting(userInfo: dictData) { (userObj, isSuccess, strMessage) in
            SVProgressHUD.dismiss()
            if(isSuccess){
                SVProgressHUD.showError(withStatus: strMessage)
                self.callProductAPI()
            }else{
                SVProgressHUD.showError(withStatus: strMessage)
            }
            
        }
        
//        let alertController = UIAlertController(title: "Abkao", message: "Please enter your password", preferredStyle: UIAlertControllerStyle.alert)
//        alertController.addTextField { (textField : UITextField) -> Void in
//            textField.placeholder = "Password"
//            
//            
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
//            print("Calncel clicked")
//            return
//        }
//        
//        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
//            
//            print((alertController.textFields?[0].text)!)
//            
//            if((alertController.textFields?[0].text)! != (ModelManager.sharedInstance.profileManager.userObj?.password)!)
//            {
//                ShowAlerts.getAlertViewConroller(globleAlert: self, DialogTitle: "Alert", strDialogMessege: "Enter correct password")
//                return
//            }
//            
//            var  dictData : [String : Any] =  [String : Any]()
//            dictData["userid"] = ModelManager.sharedInstance.profileManager.userObj?.userID
//            dictData["price_grid_dimension"] = String(describing: self.setPriceRows!)
//            dictData["image_grid_row"] = String(describing: self.setGridRows!)
//            dictData["video_url"] = self.txt_DefaultURL.text!
//            
//            SVProgressHUD.show(withStatus: "Loading.....")
//            ModelManager.sharedInstance.settingsManager.updateSetting(userInfo: dictData) { (userObj, isSuccess, strMessage) in
//                SVProgressHUD.dismiss()
//                if(isSuccess){
//                    SVProgressHUD.showError(withStatus: strMessage)
//                    self.callProductAPI()
//                }else{
//                    SVProgressHUD.showError(withStatus: strMessage)
//                }
//                
//            }
//        }
//        alertController.addAction(cancelAction)
//        alertController.addAction(okAction)
//        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func callProductAPI(){
        
        var  dictData : [String : Any] =  [String : Any]()
        dictData["userid"] = ModelManager.sharedInstance.profileManager.userObj?.userID
        SVProgressHUD.show(withStatus: "Loading.....")
        
        ModelManager.sharedInstance.productManager.getAllProducts(userID: dictData) { (productObj, isSuccess, responseMessage) in
            
            SVProgressHUD.dismiss()
            
            if(isSuccess){
                
                self.lbl_AccountName.text = ModelManager.sharedInstance.profileManager.userObj?.accountName
                self.lbl_AccountNo.text = ModelManager.sharedInstance.profileManager.userObj?.accountNo
                self.setGridRows = ModelManager.sharedInstance.settingsManager.settingObj?.imageGridRow
                self.setPriceRows = ModelManager.sharedInstance.settingsManager.settingObj?.priceGridDimention

                
                
                if (self.setGridRows == 4)
                {
                    self.setImageGrid.selectedSegmentIndex=1
                    self.setGridRows = 4
                }
                else if (self.setGridRows == 3)
                {
                    self.setImageGrid.selectedSegmentIndex=2
                    self.setGridRows = 3
                }else
                {
                    self.setImageGrid.selectedSegmentIndex=0
                    self.setGridRows = 2
                }
                
                
                //price grid
                if (self.setPriceRows) == 2{
                    self.setPriceGrid.selectedSegmentIndex=1
                    self.setPriceRows = 2
                }else if (self.setPriceRows == 3)
                {
                    self.setPriceGrid.selectedSegmentIndex=2
                    self.setPriceRows = 3
                }else{
                    self.setPriceGrid.selectedSegmentIndex=0
                    self.setPriceRows = 0
                }
                
                
                self.txt_DefaultURL.text = ModelManager.sharedInstance.settingsManager.settingObj?.videoURL

            }else{
                SVProgressHUD.showError(withStatus: responseMessage)
            }
            
        }
        
    }
    
    
    @IBAction func setImageGridRowsAction(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            setGridRows = 2
        }else if (sender.selectedSegmentIndex == 1) {
            setGridRows = 4
        }else{
            setGridRows = 3
        }
        
    }
    
    @IBAction func btn_SetImageGridAction(_ sender: UIButton) {
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "ImageCellControl") as! ImageCellControl
        myVC.getImageGridValue = setGridRows
        navigationController?.pushViewController(myVC, animated: true)
    }
    
    
    @IBAction func setImagePriceRowsAction(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            setPriceRows = 0
        }else if (sender.selectedSegmentIndex == 1) {
            setPriceRows = 2
        }else{
            setPriceRows = 3
        }
        
    }
    
    @IBAction func btn_SetPriceGridAction(_ sender: UIButton) {
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "PriceGridControl") as! PriceGridControl
        myVC.getPriceGridValue = setPriceRows
        navigationController?.pushViewController(myVC, animated: true)
    }
    
    @IBAction func btn_SaveSettings(_ sender: UIButton) {
        
        saveSetting()
    }
    
    
    
    
    @IBAction func selectColor(_ sender: UIButton) {
        
        viewColorPicker.isHidden = false
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
