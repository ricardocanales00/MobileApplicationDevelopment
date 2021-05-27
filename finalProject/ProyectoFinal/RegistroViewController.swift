//
//  RegistroViewController.swift
//  ProyectoFinal
//
//  Created by Alex Vasquez on 5/1/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegistroViewController: UIViewController {
    // Componentes de la pantalla
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var cargoTF: UITextField!
    
    /*VARIABLE NECESARIO PARA CONEXION CON FIRESTORE*/
    private let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
    @IBAction func registro(_ sender: Any) {
        if let email = emailTF.text, let pass = passwordTF.text{
            Auth.auth().createUser(withEmail: email, password: pass) { (result, error) in
                if let result = result, error == nil{
                    
                    Auth.auth().currentUser?.sendEmailVerification { (error) in
                        self.db.collection("users").document(Auth.auth().currentUser?.uid ?? " ").setData(["usuario":self.usernameTF.text ?? "","correo": email, "telefono":self.phoneTF.text ?? "", "cargo": self.cargoTF.text ?? "", "verificacion": false])
                        
                        let alertController = UIAlertController(title: "", message: "Usuario registrado exitosamente, espere a ser verificado", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                }else{
                    
                
                    let alertController = UIAlertController(title: "ERROR", message: "No se ha podido registrar su usuario", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    // Funcion para quitar el teclado al tocar la pantalla
    @IBAction func removeKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    

}
