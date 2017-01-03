//
//  UIOffsetUITextField.swift
//  dotSnipiOS
//
//  Created by raj on 23/12/16.
//  Copyright © 2016 diskodev. All rights reserved.
//

import UIKit

class UIOffsetUITextField: UITextField {

    // Provide offsets to the placeholder and edited text
    override func textRect(forBounds: CGRect) -> CGRect {
        return forBounds.offsetBy(dx: 10.0, dy: 0.0)
    }

    override func editingRect(forBounds: CGRect) -> CGRect {
        return forBounds.offsetBy(dx: 10.0, dy: 0.0)
    }

}
