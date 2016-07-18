//
//  CostumText.swift
//  BrainTeaser
//
//  Created by Meghdad Abbaszadegan on 7/16/16.
//  Copyright © 2016 Meghdad. All rights reserved.
//

import UIKit

@IBDesignable

class CostumTextField: UITextField {
    @IBInspectable var inset: CGFloat = 0
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            setUpView()
        }
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, inset, inset)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return textRectForBounds(bounds)
    }
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5.0
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    func setUpView() {
        self.layer.cornerRadius = cornerRadius
    }
}