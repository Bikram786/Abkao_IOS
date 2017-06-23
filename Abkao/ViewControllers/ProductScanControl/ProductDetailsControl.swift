//
//  ProductDetailsControl.swift
//  Abkao
//
//  Created by Inder on 11/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit

class ProductDetailsControl: AbstractControl {

    
    var getPreviousProducts = BarcodeI()
    
    @IBOutlet weak var setViewShadow: UIView!
    @IBOutlet weak var locationNameView: UIView!
    @IBOutlet weak var itemNameView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var promotionView: UIView!
    
    @IBOutlet weak var lbl_LocationName: UILabel!
    @IBOutlet weak var lbl_ItemName: UILabel!
    @IBOutlet weak var lbl_Price: UILabel!
    @IBOutlet weak var lbl_PromotionText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setIntialView()
       
    }

    func setIntialView() {
        
        print(getPreviousProducts.productLocation!)
        print(getPreviousProducts.productName!)
        print(getPreviousProducts.productRate!)
        print(getPreviousProducts.productPromotionText!)
        
        lbl_LocationName.text = getPreviousProducts.productLocation!
        lbl_ItemName.text = getPreviousProducts.productName!
        lbl_Price.text = getPreviousProducts.productRate!
        lbl_PromotionText.text = getPreviousProducts.productPromotionText!
        
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
