//
//  AgregarTareaView.swift
//  ProyectoFinal
//
//  Created by Alex Vasquez on 5/1/21.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

private let db = Firestore.firestore()
let usuariosDb = Firestore.firestore().collection("users")

class customTipoTarea: UITableViewCell {
    @IBOutlet weak var nombreCelda: UILabel!
    @IBOutlet weak var celdaTF: UITextField!
    @IBOutlet weak var opciones: UILabel!
}

protocol protocoloAgregarTarea {
    func agregarTarea(listaTarea: [Tarea])
}

class AgregarTareaView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate {
    
    private let db = Firestore.firestore()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var overView: UIView!
    
    @IBOutlet weak var nombreTF: UITextField!
    @IBOutlet weak var usuarioTF: UITextField!
    @IBOutlet weak var tipoTF: UITextField!
    @IBOutlet weak var fechaTF: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var listaUsuarios = [String]()
    
    let tipoTareas = ["-", "Riego - Valvula", "Riego - Aspersor", "Riego - Riego Manual", "Pasto", "Arbustos", "Arboles", "Baños - Limpieza", "Baños - Consumibles", "Luminarias - Inspección", "Luminarias - Reparación"]
    
    var indiceTarea : Int!
    var descripcionTarea: String!
    var ubicacion: String!
    
    let todosTiposCeldass = [
        ["No. de Valvula", "Valvula", "Solenoide", "Decodificador", "Cableado"],
        ["No. de Valvula", "Tipo", "Cambio", "Limpieza", "Ajuste", "Boquilla"],
        ["Isla", "Tipo", "Duración"],
        ["Isla", "Poda", "Corte Cajetes", "Limpieza"],
        ["Isla", "Poda", "Deshierbe", "Poda Fitosanitaria", "Aireación"],
        ["Id Árbol", "Poda Formativa", "Poda Fitosanitaria", "Poda Ramas Bajas"],
        ["Unidad", "Modulo", "Trapeo", "Desinfección", "Limpieza Sanitarios", "Recolección de Basura", "Cambio de Bolsas", "Limpieza Lavabos"],
        ["Unidad", "Modulo", "Papel Sanitario", "Jabon para Manos"],
        ["ID Luminaria", "Estado"],
        ["ID Luminaria", "Reparación Cableado", "Cambio Elemento Luminico", "Pintura", "Limpieza"]
    ]
    
    let opciones = [
        ["1 - 77", "Limpieza / Cambio", "Limpieza / Cambio", "Limpieza / Cambio", "Limpieza / Cambio"],
        ["1 - 77", "5000 / 3500 / Rociador", "Si / No", "Si / No", "Si / No", "Si / No"],
        ["1 - 32", "Manguera / Aspersión", "Minutos"],
        ["1 - 32", "Si / No", "Si / No", "Si / No", "Si / No"],
        ["1 - 32", "Si / No", "Si / No", "Si / No", "Si / No"],
        ["A/Z - 001/100", "Si / No", "Si / No", "Si / No"],
        ["1-4", "Hombres / Mujeres", "Si / No", "Si / No", "Si / No", "Si / No", "Si / No", "Si / No"],
        ["1-4", "Hombres / Mujeres", "Si / No", "Si / No"],
        ["A/C - 001/100", "Funciona, No funciona, Funciona Parcial"],
        ["A/C - 001/100", "Si / No", "Si / No", "Si / No", "Si / No"]
    ]
    
    let nombresCeldas = [String]()
    
    var listaTareas = [Tarea]()
    var delegate : protocoloAgregarTarea!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = overView.frame.size
        fechaTF.text = convertDateFormatter()
        
        let tipoPicker = UIPickerView()
        tipoPicker.tag = 1
        tipoPicker.delegate = self
        tipoTF.inputView = tipoPicker
        
        let usuariosPicker = UIPickerView()
        usuariosPicker.tag = 2
        usuariosPicker.delegate = self
        usuarioTF.inputView = usuariosPicker
        
        db.collection("users")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching collection: \(error!)")
                return
              }
                self.loadData()
            }
    }
    
    func loadData(){
        
        listaUsuarios.removeAll()
        usuariosDb.getDocuments{ (snapshot, error) in
            if let err = error{
            debugPrint("Error con las tareas")
            }
            else{
            guard let snap = snapshot else {return}
            for document in snap.documents {
                
                let data = document.data()
                let nom = data["usuario"] as? String ?? "Anonimo"
                self.listaUsuarios.append(nom)
            }
            }
        }
    }
    
    @IBAction func agregarTarea(_ sender: Any) {
        if (nombreTF.text != "" && tipoTF.text != "" && usuarioTF.text != ""){
            
            var arregloDescripcion = [String]()
            for i in 0..<todosTiposCeldass[indiceTarea].count {
                let myCell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! customTipoTarea
                if (myCell.celdaTF.text != "No" && myCell.celdaTF.text != ""){
                    arregloDescripcion.append(myCell.nombreCelda.text! + "-" + myCell.celdaTF.text!)
                }
            }
            
            if (arregloDescripcion.count == 0){
                let alert = UIAlertController(title: "Campos Incompletos", message: "Debes de llenar todos los campos en la tabla", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                
                self.present(alert, animated: true)
            }
            
            else {
                descripcionTarea = "Tarea de tipo " + tipoTF.text! + ", "
                for i in 0..<arregloDescripcion.count - 1 {
                    descripcionTarea += arregloDescripcion[i] + ", "
                }
                descripcionTarea += arregloDescripcion[arregloDescripcion.count - 1] + "."
                
                let ref = self.db.collection("tareas").addDocument(data: ["nombre": nombreTF.text!,"descripcion" : descripcionTarea, "terminado": false , "tipo" : tipoTF.text!, "fecha" : fechaTF.text!, "usuario": usuarioTF.text!])
                
                dismiss(animated: true, completion: nil)
            }
            
        }
        
        else {
            let alert = UIAlertController(title: "Campos Incompletos", message: "Debes de llenar todos los campos requeridos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1){
            return tipoTareas.count
        }
        else {
            return listaUsuarios.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1){
            return tipoTareas[row]
        }
        else {
            return listaUsuarios[row]
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 1){
            tipoTF.text = tipoTareas[row]
            tableView.reloadData()
        }
        else {
            usuarioTF.text = listaUsuarios[row]
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tipoTF.text {
        case tipoTareas[1]:
            indiceTarea = 0
            return todosTiposCeldass[0].count
        case tipoTareas[2]:
            indiceTarea = 1
            return todosTiposCeldass[1].count
        case tipoTareas[3]:
            indiceTarea = 2
            return todosTiposCeldass[2].count
        case tipoTareas[4]:
            indiceTarea = 3
            return todosTiposCeldass[3].count
        case tipoTareas[5]:
            indiceTarea = 4
            return todosTiposCeldass[4].count
        case tipoTareas[6]:
            indiceTarea = 5
            return todosTiposCeldass[5].count
        case tipoTareas[7]:
            indiceTarea = 6
            return todosTiposCeldass[6].count
        case tipoTareas[8]:
            indiceTarea = 7
            return todosTiposCeldass[7].count
        case tipoTareas[9]:
            indiceTarea = 8
            return todosTiposCeldass[8].count
        case tipoTareas[10]:
            indiceTarea = 9
            return todosTiposCeldass[9].count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaTipo", for: indexPath) as! customTipoTarea
        
        cell.nombreCelda.text = todosTiposCeldass[indiceTarea][indexPath.row]
        cell.opciones.text = opciones[indiceTarea][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func convertDateFormatter() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        let result = formatter.string(from: date)
        return result
    }
    
    @IBAction func removeKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    /*ALERT FUNC: CREATE AN ALERT WITH A COSTUME TITLE AND BODY*/
    func alert(titulo:String,mensaje: String){
        let alertController = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }

    override var shouldAutorotate: Bool {
        return false
    }
}
