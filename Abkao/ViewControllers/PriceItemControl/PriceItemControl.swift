//
//  PriceItemControl.swift
//  Abkao
//
//  Created by Inder on 12/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit

class PriceItemControl: AbstractControl {

     @IBOutlet weak var setViewShadow: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewShadow = UIView.addShadowToView(view: setViewShadow)
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
