//
//  RegisterControl.swift
//  Abkao
//
//  Created by Inder on 11/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit

class RegisterControl: AbstractControl {

    // IBOutlets
    
    @IBOutlet weak var setViewShadow: UIView!
    @IBOutlet weak var txt_FirstName: UITextField!
    @IBOutlet weak var txt_AccountNo: UITextField!
    @IBOutlet weak var txt_City: UITextField!
    @IBOutlet weak var txt_Country: UITextField!
    @IBOutlet weak var txt_UserID: UITextField!
    @IBOutlet weak var txt_LastName: UITextField!
    @IBOutlet weak var txt_AccountName: UITextField!
    @IBOutlet weak var txt_State: UITextField!
    @IBOutlet weak var txt_Telephone: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    @IBOutlet weak var txt_Company: UITextField!
    @IBOutlet weak var txt_Address: UITextField!
    @IBOutlet weak var txt_ZipCode: UITextField!
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_ConfirmPassword: UITextField!
    
    // MARK: - View Lifecycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewShadow = UIView.addShadowToView(view: setViewShadow)
    }
    
    // MARK: - Super Class Method
    
    override var showRight: Bool{
        return false
    }
    
    // MARK: - IBAction Methods
    
    
    @IBAction func btn_RegisterAction(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)
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
