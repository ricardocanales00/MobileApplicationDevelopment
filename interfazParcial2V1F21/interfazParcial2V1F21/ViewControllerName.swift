//
//  ViewControllerName.swift
//  interfazParcial2V1F21
//
//  Created by Ricardo López Canales on 06/05/21.
//

import UIKit

class ViewControllerName: UIViewController {

    @IBOutlet weak var tfNombre: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actualizaConfig()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - User Defaults
    @IBAction func guardaConfig(){
        
        let defaults = UserDefaults.standard
    
        defaults.setValue(tfNombre.text, forKey: "nombre")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guardaConfig()
        
        let vistaIni = presentingViewController as! ViewControllerTable
        
        vistaIni.actualizaConfig()
    }
    
    func actualizaConfig(){
        let defaults = UserDefaults.standard
        
        if let texto = defaults.value(forKey: "nombre") as? String {
            tfNombre.text = texto
        }
    }

}
