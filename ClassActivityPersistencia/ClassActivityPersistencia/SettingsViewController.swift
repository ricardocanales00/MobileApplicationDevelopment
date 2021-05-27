//
//  SettingsViewController.swift
//  ClassActivityPersistencia
//
//  Created by Ricardo López Canales on 16/04/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tfNimbre: UITextField!
    @IBOutlet weak var sgCellsIZE: UISegmentedControl!
    @IBOutlet weak var SW: UISwitch!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        actualizarSettings()
    }
    
    @IBAction func guardaConfig(){
        let defaults = UserDefaults.standard
        defaults.setValue(tfNimbre.text, forKey: "nombre")
        defaults.set(sgCellsIZE.selectedSegmentIndex, forKey: "tamano")
        defaults.set(SW.isOn, forKey: "color")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guardaConfig()
        
        let vistaHome = presentingViewController as! ViewController
        
        vistaHome.actualizarSettings()
    }
    
    func actualizarSettings(){
        let defaults = UserDefaults.standard
        
        if let nombre = defaults.value(forKey: "nombre") as? String {
            tfNimbre.text = nombre
        }
        
        let celd = defaults.integer(forKey: "tamano")
        sgCellsIZE.selectedSegmentIndex = celd
        
        let boole = defaults.bool(forKey: "color")
        SW.isOn = boole
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
