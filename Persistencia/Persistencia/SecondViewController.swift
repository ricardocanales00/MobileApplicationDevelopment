//
//  SecondViewController.swift
//  Persistencia
//
//  Created by Ricardo López Canales on 15/04/21.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var tfString: UITextField!
    @IBOutlet weak var tfInteger: UITextField!
    @IBOutlet weak var slide: UISlider!
    @IBOutlet weak var sw: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actualizarInterfaz()
    }
    
    func actualizarInterfaz(){
        let defaults = UserDefaults.standard
        
        if let texto = defaults.value(forKey: "Texto") as? String {
            tfString.text = texto
        }
        
        let entero = defaults.integer(forKey: "entero")
        tfInteger.text = String(entero)
        
        let flotante = defaults.float(forKey: "flotante")
        slide.value = flotante
        
        let boole = defaults.bool(forKey: "booleano")
        sw.isOn = boole
    }
    
    @IBAction func guardarDatos() {
        let defaults = UserDefaults.standard
        
        defaults.setValue(tfString.text, forKey: "Texto")
        if let entero = Int(tfInteger.text!){
            defaults.set(entero, forKey: "entero")
        }
        defaults.set(slide.value, forKey: "flotante")
        defaults.set(sw.isOn, forKey: "booleano")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guardarDatos()
        
        let viewHome = presentingViewController as! ViewController
        viewHome.actualizarInterfaz()
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
