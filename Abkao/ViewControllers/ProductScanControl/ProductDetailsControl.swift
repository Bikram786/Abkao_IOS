//
//  ProductDetailsControl.swift
//  Abkao
//
//  Created by Inder on 11/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit

class ProductDetailsControl: AbstractControl {
    
    var productBarCode : String?
    var getPreviousProducts : BarcodeI?
    
    
    @IBOutlet weak var btnTransfer: UIButton!
    
    @IBOutlet weak var setViewShadow: UIView!
    @IBOutlet weak var locationNameView: UIView!
    @IBOutlet weak var itemNameView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var promotionView: UIView!
    
    
    @IBOutlet weak var lbl_BarcodeNo: UILabel!
    @IBOutlet weak var lbl_AccountNo: UILabel!
    
    @IBOutlet weak var lbl_LocationName: UILabel!
    @IBOutlet weak var lbl_ItemName: UILabel!
    @IBOutlet weak var lbl_Price: UILabel!
    @IBOutlet weak var lbl_PromotionText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         btnTransfer.isHidden = true
        
        print(ModelManager.sharedInstance.profileManager.userObj!.accountNo ?? "")
        
        
        setIntialView()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
        ModelManager.sharedInstance.barcodeManager.isBarcodeDetailsOpen = true
    }
    
    
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(true)
        
        ModelManager.sharedInstance.barcodeManager.isBarcodeDetailsOpen = false

    }
    
    func setIntialView() {
        
        lbl_BarcodeNo.text = ModelManager.sharedInstance.barcodeManager.barCodeValue
        
        lbl_AccountNo.text = ModelManager.sharedInstance.profileManager.userObj?.accountNo
        
        if let proLocation = getPreviousProducts?.productLocation
        {
            lbl_LocationName?.text = proLocation
        }
        
        if let proName = getPreviousProducts?.productName
        {
            lbl_ItemName?.text = proName
        }
        
        if let proPrice = getPreviousProducts?.productPromotionPrice
        {
            lbl_Price?.text = proPrice
        }
        
        if let proPromotionText = getPreviousProducts?.productPromotionText
        {
            lbl_PromotionText?.text = proPromotionText
        }
        
        if(lbl_ItemName?.text == "")
        {
            btnTransfer.isHidden = false
        }
        
        //temp code
//        btnTransfer.isHidden = false
        
        
        /*
        setViewShadow.viewdraw(setViewShadow.bounds)
        locationNameView.setViewBoarder()
        itemNameView.setViewBoarder()
        priceView.setViewBoarder()
        promotionView.setViewBoarder()
      */
    }
    
    
    
    override var navTitle: String{
        return "OnlyLeftBack"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clkBtnTransfer(_ sender: UIButton) {
        
        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "question1") as! Question1
        self.navigationController?.pushViewController(myVC, animated: true)
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
