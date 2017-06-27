//
//  PriceGrid.swift
//  Abkao
//
//  Created by CSPC162 on 15/06/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class PriceGrid: UITableViewCell {

    
    @IBOutlet weak var setBoarderView: UIView!
    @IBOutlet weak var lbl_ProductName: UILabel!    
    @IBOutlet weak var lbl_ProductPrice: UILabel!
    @IBOutlet weak var setView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
