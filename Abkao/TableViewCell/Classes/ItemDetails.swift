//
//  ItemDetails.swift
//  Abkao
//
//  Created by CSPC162 on 15/06/17.
//  Copyright © 2017 Inder. All rights reserved.
//

import UIKit

class ItemDetails: UITableViewCell {

    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var lbl_ItemTitle: UILabel!
    @IBOutlet weak var lbl_ItemPrice: UILabel!
    @IBOutlet weak var setShadow: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
