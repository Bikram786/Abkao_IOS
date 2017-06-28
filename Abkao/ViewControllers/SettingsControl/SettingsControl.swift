//
//  SettingsControl.swift
//  Abkao
//
//  Created by Inder on 11/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit
import SVProgressHUD

class SettingsControl: AbstractControl {

    var setGridRows:Int?
    var setPriceRows:Int?
    
     @IBOutlet weak var setViewShadow: UIView!
     @IBOutlet weak var txt_DefaultURL: UITextField!
    @IBOutlet weak var setImageGrid: UISegmentedControl!
    @IBOutlet weak var setPriceGrid: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        callProductAPI()
        
    }

    // MARK: - Super Class Method
    
    override var navTitle: String{
        return "Logout"
    }
    
    func saveSetting(){
        
        var  dictData : [String : Any] =  [String : Any]()
        dictData["userid"] = ModelManager.sharedInstance.profileManager.userObj?.userID
        dictData["price_grid_dimension"] = String(describing: setPriceRows!)
        dictData["image_grid_row"] = String(describing: setGridRows!)
        dictData["video_url"] = "https://www.youtube.com/watch?v=5ahMQwxN9Js"
        
        SVProgressHUD.show(withStatus: "Loding.....")
        ModelManager.sharedInstance.settingsManager.updateSetting(userInfo: dictData) { (userObj, isSuccess, strMessage) in
            SVProgressHUD.dismiss()
            if(isSuccess){
                SVProgressHUD.showError(withStatus: strMessage)
                self.callProductAPI()
            }else{
                SVProgressHUD.showError(withStatus: strMessage)
            }
            
        }
    }
    
    func callProductAPI(){
        
        var  dictData : [String : Any] =  [String : Any]()
        dictData["userid"] = ModelManager.sharedInstance.profileManager.userObj?.userID
        SVProgressHUD.show(withStatus: "Loding.....")
        
        ModelManager.sharedInstance.productManager.getAllProducts(userID: dictData) { (productObj, isSuccess, responseMessage) in
            
            SVProgressHUD.dismiss()
            
            if(isSuccess){
                
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
