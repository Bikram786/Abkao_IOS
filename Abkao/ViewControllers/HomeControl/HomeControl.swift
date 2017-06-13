//
//  HomeControl.swift
//  Abkao
//
//  Created by Inder on 10/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit

class HomeControl: AbstractControl {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var navTitle: String {
        
        return "Setting"
    }
    
    override func gotoScanView() {
        
        self.performSegue(withIdentifier: "goto_scanbarcodeview", sender: nil)
    }
    
    override func gotoSettingView() {
        
        self.performSegue(withIdentifier: "goto_settingview", sender: nil)
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
