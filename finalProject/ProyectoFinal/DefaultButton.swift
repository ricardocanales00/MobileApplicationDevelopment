//
//  DefaultButton.swift
//  ProyectoFinal
//
//  Created by Ricardo López Canales on 27/05/21.
//

import UIKit

class DefaultButton: UIButton {
    
    override func awakeFromNib() {
           setupView()
       }

       override func prepareForInterfaceBuilder() {
           super.prepareForInterfaceBuilder()
           setupView()
       }
    
    func setupView() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.systemPink.cgColor, UIColor.systemPink.cgColor]
        layer.addSublayer(gradient)
        gradient.cornerRadius = 15
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

}
