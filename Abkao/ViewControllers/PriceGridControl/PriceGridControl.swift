//
//  PriceGridControl.swift
//  Abkao
//
//  Created by Inder on 12/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit

class PriceGridControl: AbstractControl,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var priceTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        priceTable.delegate = self
        priceTable.dataSource = self
        priceTable.register(UINib(nibName: "PriceGrid", bundle: nil), forCellReuseIdentifier: "PriceGrid")
        priceTable.estimatedRowHeight = 50.0
        priceTable.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: - Super Class Method
    
    override var navTitle: String{
        return "Logout"
    }
    
    //MARK: - UITableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PriceGrid", for: indexPath) as! PriceGrid
        cell.lbl_ProductName.text = "hiiiii"
        cell.lbl_ProductPrice.text = "5.0"
        return cell
        
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
