//
//  LoginControl.swift
//  Abkao
//
//  Created by CSPC162 on 09/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit

class LoginControl: AbstractControl {

    // IBOutlets
    
    @IBOutlet weak var setViewShadow: UIView!
    @IBOutlet weak var txt_UserID: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    
    // MARK: - View Lifecycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setShadow()
    }
    
    //MARK: - Set Shadow
    
    func setShadow() {
        
        setViewShadow = UIView.addShadowToView(view: setViewShadow)
        txt_UserID = UITextField.addShadowToTextfield(view: txt_UserID)
        txt_Password = UITextField.addShadowToTextfield(view: txt_Password)

    }
    
    // MARK: - Super Class Method
    
    override var showLeft: Bool{
        return false
    }
    
    override var showRight: Bool{
        return false
    }
    
    // MARK: - IBAction Methods
    
    @IBAction func btn_LoginAction(_ sender: UIButton) {
    }
    
    
    // MARK: - Memory Management Method
    
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
