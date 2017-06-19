//
//  PriceGridControl.swift
//  Abkao
//
//  Created by Inder on 12/06/17.
//  Copyright © 2017 CSPC162. All rights reserved.
//

import UIKit

class PriceGridControl: AbstractControl,UITableViewDelegate, UITableViewDataSource {
    
    var getPriceGridValue:Int?
    
    @IBOutlet weak var priceTable: UITableView!
    @IBOutlet weak var setBoarderView: UIView!
    @IBOutlet weak var btn_ShowItems: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        priceTable.delegate = self
        priceTable.dataSource = self
        priceTable.register(UINib(nibName: "PriceGrid", bundle: nil), forCellReuseIdentifier: "PriceGrid")
        priceTable.estimatedRowHeight = 100
        priceTable.rowHeight = UITableViewAutomaticDimension
        priceTable.separatorStyle = .none
        priceTable.tableFooterView = UIView()
        setBoarderView.viewdraw(setBoarderView.bounds)
        
        print(String(getPriceGridValue!*getPriceGridValue!))
        
        let setValue = "Add " + String(getPriceGridValue!*getPriceGridValue!) + " Items"
        
        btn_ShowItems.setTitle(setValue, for: .normal)
        
    }
    
    // MARK: - Super Class Method
    
    override var navTitle: String{
        return "Logout"
    }
    
    //MARK: - UITableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PriceGrid", for: indexPath) as! PriceGrid
        cell.lbl_ProductName.text = "hiiiii"
        cell.productNameView.setViewBoarder()
        cell.lbl_ProductPrice.text = "5.0"
        cell.productPriceView.setViewBoarder()
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
