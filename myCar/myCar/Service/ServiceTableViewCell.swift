//
//  ServiceTableViewCell.swift
//  myCar
//
//  Created by Michał on 10/04/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {
    
    let serviceTypeLabel = UILabel()
    let serviceCostLabel = UILabel()
    let serviceDateLabel = UILabel()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(serviceTypeLabel)
        contentView.addSubview(serviceCostLabel)
        contentView.addSubview(serviceDateLabel)
        
        serviceTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120).isActive = true
        serviceTypeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 100).isActive = true
        serviceTypeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -100).isActive = true
        serviceTypeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        serviceDateLabel.topAnchor.constraint(equalTo: serviceTypeLabel.bottomAnchor, constant: 15).isActive = true
        serviceDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 100).isActive = true
        serviceDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -100).isActive = true
        serviceDateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        serviceCostLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 155).isActive = true
        serviceCostLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 200).isActive = true
        serviceCostLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -200).isActive = true
        serviceCostLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
