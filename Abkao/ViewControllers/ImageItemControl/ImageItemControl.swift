//
//  ImageItemControl.swift
//  Abkao
//
//  Created by Inder on 12/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit

class ImageItemControl: AbstractControl {

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
        
        // upperView.upperdraw(upperView.bounds)
        setViewShadow.viewdraw(setViewShadow.bounds)
        txt_ImageURL.addShadowToTextfield()
        txt_ProductName.addShadowToTextfield()
        txt_ProductPrice.addShadowToTextfield()
        txt_VideoURL.addShadowToTextfield()
        
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
