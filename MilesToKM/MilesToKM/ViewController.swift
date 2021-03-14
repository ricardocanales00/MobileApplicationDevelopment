//
//  ViewController.swift
//  MilesToKM
//
//  Created by Ricardo López Canales on 17/02/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var lbMessage: UILabel!
    @IBOutlet weak var tfKm: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculate(_ sender: UIButton) {
        if let miles = Double(tfInput.text!){
            let calculation = miles * 1.60934
            
            tfKm.text = String(calculation)
        }
        else {
            let alerta = UIAlertController(title: "ERROR", message:"Incorrect data was inputed" , preferredStyle: .alert)
            let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alerta.addAction(accion)
            
            present(alerta, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func quitaTeclado(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}

