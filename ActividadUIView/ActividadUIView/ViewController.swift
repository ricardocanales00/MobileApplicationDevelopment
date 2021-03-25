//
//  ViewController.swift
//  ActividadUIView
//
//  Created by Ricardo López Canales on 23/03/21.
//

import UIKit

class ViewController: UIViewController {
    
    //Elementos
    @IBOutlet weak var vColor: UIView!
    @IBOutlet weak var sBackground: UISegmentedControl!
    @IBOutlet weak var imOriginal: UIImageView!
    @IBOutlet weak var sColor: UISlider!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backgroundChange(_ sender: UISegmentedControl) {
        switch sBackground.selectedSegmentIndex {
        case 0:
            UIView.animate(withDuration: 1){
                self.view.backgroundColor = .white;
            }
        case 1:
            UIView.animate(withDuration: 1){
                self.view.backgroundColor = . gray;
            }
        default:
            break;
        }
        
    }
    
    @IBAction func sliderCortina(_ sender: UISlider) {
        vColor.frame.origin.x = CGFloat(sColor.value) * 360;
    }
    
}

