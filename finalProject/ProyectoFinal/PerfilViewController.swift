//
//  PerfilViewController.swift
//  ProyectoFinal
//
//  Created by Alex Vasquez on 5/1/21.
//

import UIKit

class PerfilViewController: UIViewController {
    // Componentes
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var correoLabel: UILabel!
    @IBOutlet weak var telefonoLabel: UILabel!
    @IBOutlet weak var cargoLabel: UILabel!
    
    override func viewDidLoad() {
        if let correo = UserDefaults.standard.string(forKey: "correo"){
            correoLabel.text = correo
            correoLabel.sizeToFit()
            if let cell = UserDefaults.standard.string(forKey: "telefono"){
                telefonoLabel.text = cell
                telefonoLabel.sizeToFit()
            }
                if let cargo = UserDefaults.standard.string(forKey: "cargo"){
                    cargoLabel.text = cargo
                    cargoLabel.sizeToFit()
                }
                    if let nombre = UserDefaults.standard.string(forKey: "usuario"){
                        nombreLabel.text = nombre
                        nombreLabel.sizeToFit()
                    }
        }
        super.viewDidLoad()
    }
    
    @IBAction func cerrasSesion(_ sender: Any) {

        let alert = UIAlertController(title: "Cerrar Sesión", message: "Estas seguro de que quieres cerrar sesión", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: { (action : UIAlertAction!) in
        }))
        
        alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: { [self] (action : UIAlertAction!) in
            dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)

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
