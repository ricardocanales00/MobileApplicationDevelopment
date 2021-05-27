//
//  SettingsViewController.swift
//  ActPersistenciaPDM
//
//  Created by Ricardo López Canales on 06/05/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var scSize: UISegmentedControl!
    @IBOutlet weak var swColor: UISwitch!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - User Defaults
    @IBAction func guardaConfig(){
        let defaults = UserDefaults.standard
        
        
        defaults.setValue(tfNombre.text, forKey: "nombre")
        defaults.set(swColor.isOn, forKey: "backgrd")
        defaults.set(scSize.selectedSegmentIndex, forKey: "sizeCell")

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guardaConfig()
        
        let vistaIni = presentingViewController as! ViewController
        
        vistaIni.confi()
    }
    
    func actualizaConfig(){
        let defaults = UserDefaults.standard
        
        if let texto = defaults.value(forKey: "nombre") as? String {
            tfNombre.text = texto
        }
        
        let celda = defaults.integer(forKey: "sizeCell")
        scSize.selectedSegmentIndex = celda
        
        let booleano = defaults.bool(forKey: "backgrd")
        swColor.isOn = booleano
    }

}
