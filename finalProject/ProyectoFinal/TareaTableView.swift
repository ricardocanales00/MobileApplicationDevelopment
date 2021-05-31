//
//  TareaTableView.swift
//  ProyectoFinal
//
//  Created by Alex Vasquez on 5/1/21.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class customTareaCell: UITableViewCell {
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var usuario: UILabel!
    @IBOutlet weak var descripcion: UITextView!
}

class TareaTableView: UITableViewController, protocoloAgregarTarea {
    
    // Lista de tareas
    @IBOutlet weak var addButton: UIBarButtonItem!
    var listaTareas = [Tarea]()
    
    private let db = Firestore.firestore()
    let reporteCollectionRef = Firestore.firestore().collection("tareas")
    let admin = UserDefaults.standard.bool(forKey: "admin")

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tareas"
        db.collection("tareas")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching collection: \(error!)")
                return
              }
                self.loadData()
            }
        if admin{
            self.navigationItem.leftBarButtonItem = self.editButtonItem
            addButton.isEnabled = true
        }else{
            addButton.isEnabled = false
        }
    }
    
    // MARK: -LOAD DATA
    func loadData(){
        
        listaTareas.removeAll()
        reporteCollectionRef.getDocuments{ (snapshot, error) in
            if let err = error{
            debugPrint("Error con las tareas")
            }
            else{
            guard let snap = snapshot else {return}
            for document in snap.documents {
                
                let data = document.data()
                let terminado = data["terminado"] as? Bool
                if terminado == false{
                    

                    let nom = data["nombre"] as? String ?? "Anonimo"
                    let fecha = data["fecha"] as? String ?? ""
                    let descripcion = data["descripcion"] as? String ?? " "
                    let usuario = data["usuario"] as? String ?? " "
                    let tipo = data["tipo"] as? String ?? " "
                    let newTarea = Tarea(nombre: nom, tipo: tipo, usuario: usuario, fecha: fecha, descripcion: descripcion, key: document.documentID)
                    self.listaTareas.append(newTarea)
                    }
                }

            self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaTareas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaTarea", for: indexPath) as! customTareaCell

        // Configure the cell...
        cell.nombre.text = listaTareas[indexPath.row].nombre
        cell.fecha.text = listaTareas[indexPath.row].fecha
        cell.descripcion.text = listaTareas[indexPath.row].descripcion
        cell.usuario.text = listaTareas[indexPath.row].usuario
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alert = UIAlertController(title: "Eliminar Tarea", message: "Estas seguro de que quieres eliminar esta tarea", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: { (action : UIAlertAction!) in
            }))
            
            alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: { (action : UIAlertAction!) in
                self.listaTareas.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }))
            
            present(alert, animated: true, completion: nil)

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueAgregarTarea"){
            let agregarView = segue.destination as! AgregarTareaView
            agregarView.delegate = self
            agregarView.listaTareas = listaTareas
        }
    }
    
    // Funcion del protocolo para agregar tarea
    func agregarTarea(listaTarea: [Tarea]) {
        listaTareas = listaTarea
        tableView.reloadData()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }

    override var shouldAutorotate: Bool {
        return false
    }
}
