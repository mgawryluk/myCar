//
//  InsuranceTableViewCell.swift
//  myCar
//
//  Created by Michał on 10/04/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import UIKit

class InsuranceTableViewCell: UITableViewCell {
    
    let insuranceTypeLabel = UILabel()
    let insuranceCostLabel = UILabel()
    let insuranceDateLabel = UILabel()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(insuranceTypeLabel)
        contentView.addSubview(insuranceCostLabel)
        contentView.addSubview(insuranceDateLabel)
        
        insuranceTypeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        insuranceTypeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        insuranceTypeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -130).isActive = true
//        insuranceTypeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        insuranceTypeLabel.textColor = UIColor.black
        insuranceTypeLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        insuranceTypeLabel.textAlignment = .left
        insuranceTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        insuranceDateLabel.topAnchor.constraint(equalTo: insuranceTypeLabel.bottomAnchor, constant: 20).isActive = true
        insuranceDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        insuranceDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -130).isActive = true
//        insuranceDateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        insuranceDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        insuranceDateLabel.textColor = UIColor.darkGray
        insuranceDateLabel.font = UIFont.systemFont(ofSize: 15)
        insuranceDateLabel.textAlignment = .left
        insuranceDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        insuranceCostLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        insuranceCostLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        insuranceCostLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0)
//        insuranceCostLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        insuranceCostLabel.textColor = UIColor.black
        insuranceCostLabel.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        insuranceCostLabel.textAlignment = .left
        insuranceCostLabel.translatesAutoresizingMaskIntoConstraints = false
        
        insuranceCostLabel.numberOfLines = 0
        insuranceDateLabel.numberOfLines = 0
        insuranceTypeLabel.numberOfLines = 0
    
    }
    
    
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
