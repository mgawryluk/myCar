//
//  RepairTableViewCell.swift
//  myCar
//
//  Created by Michał on 27/03/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit

class RepairTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repairTypeLabel: UILabel!
    @IBOutlet weak var repairDateLabel: UILabel!
    @IBOutlet weak var repairCostLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

   
    }

}
