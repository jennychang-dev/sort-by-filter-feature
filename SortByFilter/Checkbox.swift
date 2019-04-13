//
//  Checkbox.swift
//  SortByFilter
//
//  Created by Jenny Chang on 11/04/2019.
//  Copyright © 2019 Jenny Chang. All rights reserved.
//

import UIKit

class CheckboxButton: UIButton {
    var alternateButton:Array<CheckboxButton>?
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
    }
}
