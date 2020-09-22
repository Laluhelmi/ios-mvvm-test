//
//  MaterialRawCell.swift
//  Mvvm
//
//  Created by laluheri on 9/22/20.
//  Copyright © 2020 hazard. All rights reserved.
//

import UIKit

class MaterialRawCell: UITableViewCell {

    @IBOutlet weak var sku: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
