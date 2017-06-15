//
//  ProductDetailsControl.swift
//  Abkao
//
//  Created by Inder on 11/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit

class ProductDetailsControl: AbstractControl {

    @IBOutlet weak var setViewShadow: UIView!
    @IBOutlet weak var locationNameView: UIView!
    @IBOutlet weak var itemNameView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var promotionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewShadow.viewdraw(setViewShadow.bounds)
        locationNameView.setViewBoarder()
        itemNameView.setViewBoarder()
        priceView.setViewBoarder()
        promotionView.setViewBoarder()
    }

    override var navTitle: String{
        return "Logout"
    }
    
    override func gotoLoginView() {
        
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
