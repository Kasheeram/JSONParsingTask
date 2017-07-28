//
//  JSON_TableViewCell.swift
//  JSONParsingTask1
//
//  Created by vinay on 10/01/17.
//  Copyright © 2017 CodeYeti. All rights reserved.
//

import UIKit

class JSON_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var machineID: UILabel!
    @IBOutlet weak var orderID: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var unitPrice: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var total: UILabel!
    
    @IBOutlet weak var headerButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
