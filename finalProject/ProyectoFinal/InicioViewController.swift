//
//  InicioViewController.swift
//  ProyectoFinal
//
//  Created by Alex Vasquez on 5/1/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class InicioViewController: UIViewController {
    // Componentes
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signin: UIButton!
    
    /*DATABASE COMPONENTS*/
    private let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // Funcion para quitar el teclado
    @IBAction func removeKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func signin(_ sender: Any) {
        if let email = usernameTF.text, let pass = passwordTF.text{
            Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
                if  let result = result, error == nil{
                    
                    self.db.collection("users").document(Auth.auth().currentUser?.uid ?? "").getDocument{
                        (documentSnapshot, error) in
                        if let document = documentSnapshot, error == nil{
                            if let telefono = document.get("telefono") as? String{
                                if let usuario = document.get("usuario") as? String{
                                    if let cargo = document.get("cargo") as? String, let correo = document.get("correo") as? String{
                                        let verificacion = document.get("verificacion") as? Bool
                                        if  verificacion == true{
                                            let user = UserDefaults.standard
                                            user.set(String(email), forKey: "correo")
                                            user.set(String(telefono), forKey: "telefono")
                                            user.set(String(cargo), forKey: "cargo")
                                            user.set(String(usuario), forKey: "usuario")
                                            self.performSegue(withIdentifier: "tabbar", sender: self)
                                        }else{
                                            self.alert(titulo: "Error", mensaje: "Email no verificado")
                                        }
                                        
                                        
                                    }else{
                                        self.alert(titulo: "Error", mensaje: "No se ha podido obtener el cargo")
                                    }
                                }else{
                                    self.alert(titulo: "Error", mensaje: "No se ha podido obtener el nombre de usuario")
                                }
                            }else{
                                self.alert(titulo: "Error", mensaje: "No se ha podido obtener el número de teléfono")
                            }
                        }
                    }
                }else{
                    self.alert(titulo: "Error", mensaje: "Usuario o contraseña incorrectos")
                }
            }
        }
    }
    func alert(titulo:String,mensaje: String){
        let alertController = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
