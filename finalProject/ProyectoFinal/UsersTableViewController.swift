//
//  UsersTableViewController.swift
//  ProyectoFinal
//
//  Created by Alex Vasquez on 5/28/21.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

private let db = Firestore.firestore()
let reporteCollectionRef = Firestore.firestore().collection("users")

class celdaUsuario : UITableViewCell {
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var telefono: UILabel!
    @IBOutlet weak var cargo: UILabel!
    @IBOutlet weak var correo: UILabel!
    @IBOutlet weak var verificador: UISwitch!
    var estatus : Bool!
    var id: String!
    
    @IBAction func switchDidChange(_ sender: UISwitch) {
        if sender.isOn{
            db.collection("users").document(id).updateData(["verificacion": true])
        }else{
            db.collection("users").document(id).updateData(["verificacion": false])
        }
    }
}

class UsersTableViewController: UITableViewController {
    
    var listaUsuario = [Usuario]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Usuarios"
        db.collection("users")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching collection: \(error!)")
                return
              }
                self.loadData()
            }
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: -LOAD DATA
    func loadData(){
        
        listaUsuario.removeAll()
        reporteCollectionRef.getDocuments{ (snapshot, error) in
            if let err = error{
            debugPrint("Error con las tareas")
            }
            else{
            guard let snap = snapshot else {return}
            for document in snap.documents {
                
                let data = document.data()

                    let nom = data["usuario"] as? String ?? "Anonimo"
                    let correo = data["correo"] as? String ?? ""
                    let cargo = data["cargo"] as? String ?? " "
                    let telefono = data["telefono"] as? String ?? " "
                    let admin = data["tipo"] as? Bool
                    let verificacion = data["verificacion"] as? Bool
                let id = document.documentID
                let nuevoUsuario = Usuario(nombre: nom, cargo: cargo, correo: correo, telefono: telefono, admin: admin ?? false, verificacion: verificacion ?? false, id: id)

                    self.listaUsuario.append(nuevoUsuario)
                    }

            self.tableView.reloadData()
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaUsuario.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! celdaUsuario
        // Configure thecell...
        //cell.nombre.text = listaUsuario[indexPath.row].nombre
        //cell.textLabel?.text = listaUsuario[indexPath.row].nombre
        cell.correo.text = listaUsuario[indexPath.row].correo
        cell.correo.sizeToFit()
        cell.nombre.text = listaUsuario[indexPath.row].nombre
        cell.nombre.sizeToFit()
        cell.telefono.text = listaUsuario[indexPath.row].telefono
        cell.telefono.sizeToFit()
        cell.cargo.text = listaUsuario[indexPath.row].cargo
        cell.cargo.sizeToFit()
        cell.id = listaUsuario[indexPath.row].id
        cell.verificador.setOn(listaUsuario[indexPath.row].verificacion, animated: false)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alert = UIAlertController(title: "Eliminar Tarea", message: "Estas seguro de que quieres eliminar esta tarea", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: { (action : UIAlertAction!) in
            }))
            
            alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: { (action : UIAlertAction!) in
                self.listaUsuario.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }))
            
            present(alert, animated: true, completion: nil)

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }

    override var shouldAutorotate: Bool {
        return false
    }
}
