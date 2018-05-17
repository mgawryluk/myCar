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
        
        serviceTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        serviceTypeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        serviceTypeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -130).isActive = true
//        serviceTypeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        serviceTypeLabel.textColor = UIColor.black
        serviceTypeLabel.font = UIFont.systemFont(ofSize: 17)
        serviceTypeLabel.textAlignment = .left
        serviceTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        serviceDateLabel.topAnchor.constraint(equalTo: serviceTypeLabel.bottomAnchor, constant: 20).isActive = true
        serviceDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        serviceDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -130).isActive = true
//        serviceDateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        serviceDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        serviceDateLabel.textColor = UIColor.black
        serviceDateLabel.font = UIFont.systemFont(ofSize: 17)
        serviceDateLabel.textAlignment = .left
        serviceDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        serviceCostLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        serviceCostLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        serviceCostLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0)
//        serviceCostLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        serviceCostLabel.textColor = UIColor.black
        serviceCostLabel.font = UIFont.systemFont(ofSize: 17)
        serviceCostLabel.textAlignment = .left
        serviceCostLabel.translatesAutoresizingMaskIntoConstraints = false
        
        serviceCostLabel.numberOfLines = 0
        serviceDateLabel.numberOfLines = 0
        serviceTypeLabel.numberOfLines = 0
    
    }
    
    
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
