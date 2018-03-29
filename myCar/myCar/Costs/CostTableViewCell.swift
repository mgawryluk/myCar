//
//  CostTableViewCell.swift
//  myCar
//
//  Created by Michał on 23/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit

class CostTableViewCell: UITableViewCell {

    @IBOutlet weak var costTypeLabel: UILabel!
    @IBOutlet weak var costDateLabel: UILabel!
    @IBOutlet weak var costAmountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
