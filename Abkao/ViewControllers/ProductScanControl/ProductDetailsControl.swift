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
        setIntialView()
    }
    
    func setIntialView() {
        
        lbl_BarcodeNo.text = productBarCode
        
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
        
        
        setViewShadow.viewdraw(setViewShadow.bounds)
        locationNameView.setViewBoarder()
        itemNameView.setViewBoarder()
        priceView.setViewBoarder()
        promotionView.setViewBoarder()
    }
    
    
    
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
