//
//  ViewController.swift
//  Persistencia
//
//  Created by Ricardo López Canales on 15/04/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var tfNumber1: UITextField!
    @IBOutlet weak var tfNumber2: UITextField!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let app = UIApplication.shared
        
        NotificationCenter.default.addObserver(self, selector: #selector(guardarDatos), name: UIApplication.didEnterBackgroundNotification, object: app)
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guardarDatos()
    }


}

