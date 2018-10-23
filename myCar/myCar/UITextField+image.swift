//
//  UITextField+image.swift
//  myCar
//
//  Created by Michał on 17/10/2018.
//  Copyright © 2018 Michał Gawryluk. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func setIcon(name: String) {
        let iconView = UIImageView(frame:
            CGRect(x: 5, y: 5, width: 20, height: 20))
        iconView.image = UIImage(named: name)
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 10, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}
