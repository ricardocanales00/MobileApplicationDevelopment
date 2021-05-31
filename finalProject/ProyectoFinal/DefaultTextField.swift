//
//  DefaultTextField.swift
//  ProyectoFinal
//
//  Created by Ricardo López Canales on 27/05/21.
//

import UIKit

struct baseTextField {
    let textF : UITextField?
}

class DefaultTextField: UITextField {
    
    override func awakeFromNib() {
           setupView()
       }

       override func prepareForInterfaceBuilder() {
           super.prepareForInterfaceBuilder()
           setupView()
       }
    
    func setupView() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: frame.size.height-2, width: frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.init(red: 155/255, green: 155/255, blue: 155/255, alpha: 1).cgColor
        
        self.borderStyle = .none
        
        self.layer.addSublayer(bottomLine)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

}
