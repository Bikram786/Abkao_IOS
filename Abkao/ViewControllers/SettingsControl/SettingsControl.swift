//
//  SettingsControl.swift
//  Abkao
//
//  Created by Inder on 11/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit

class SettingsControl: AbstractControl {

    var setGridRows:Int?
    var setPriceRows:Int?
    
     @IBOutlet weak var setViewShadow: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewShadow.viewdraw(setViewShadow.bounds)
        setGridRows=2
        setPriceRows=0
        
    }

    // MARK: - Super Class Method
    
    override var navTitle: String{
        return "Logout"
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
