//
//  ReporteTableView.swift
//  ProyectoFinal
//
//  Created by Alex Vasquez on 5/1/21.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class customReporteCell : UITableViewCell {
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var prioridad: UILabel!
    @IBOutlet weak var fecha: UILabel!
}

class ReporteTableView: UITableViewController, protocoloAgregarReporte, protocoloCompletarReporte {
    
    var listaReportes = [Reporte]()
    private let db = Firestore.firestore()
    let reporteCollectionRef = Firestore.firestore().collection("reporte")
    private let storage = Storage.storage().reference()
    
    /*Pruebas para guardar eliminar*/
    let documentsID : [String] = []
    private let iterator = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reportes"
        
        db.collection("reporte")
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
        
        listaReportes.removeAll()
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
                    
                    var imagen : UIImage!
                    
                    self.storage.child("imagenes/" + document.documentID + ".jpeg").downloadURL(completion: {url, error in
                        guard let url = url, error == nil else{
                            return
                        }
                        let urlString = url.absoluteString
                        
                        DispatchQueue.main.async {
                            imagen = imagen
                        }
                        
                        
                        guard let urlDirection = URL(string: urlString) else {
                            return
                        }
                        let task = URLSession.shared.dataTask(with: urlDirection, completionHandler: {data, _, error in
                            guard let data = data, error == nil else{
                                return
                            }
                            DispatchQueue.main.async {
                                imagen = UIImage(data: data)
                            }
                        })
                        task.resume()
                        print("****************" + urlString + "******************" )
                    })
                    
                    let nom = data["nombre"] as? String ?? "Anonimo"
                    let lugar = data["lugar"] as? String ?? "Desconocido"
                    let fecha = data["fecha"] as? String ?? ""
                    let descripcion = data["descripcion"] as? String ?? " "
                    let prioridad = data["prioridad"] as? Double ?? 5
                        
                        let newReporte = Reporte(nombre: nom, lugar: lugar, fecha: fecha, descripcion: descripcion, prioridad: prioridad, imagen:imagen, key: document.documentID)
                        
                    self.listaReportes.append(newReporte)
                    }
                }

            self.tableView.reloadData()
            }
        }
    }
    // MARK: - Image Download
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, reporte: Reporte) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                reporte.imagen = UIImage(data: data)
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
        return listaReportes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celdaReporte", for: indexPath) as! customReporteCell

        // Configure the cell...
        cell.nombre.text = listaReportes[indexPath.row].nombre
        cell.fecha.text = listaReportes[indexPath.row].fecha
        cell.prioridad.text = String(listaReportes[indexPath.row].prioridad)
        //cell.lugar.text = "Lugar: " + listaReportes[indexPath.row].lugar
        cell.imagen.image = listaReportes[indexPath.row].imagen
        
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
            
            let alert = UIAlertController(title: "Eliminar Reporte", message: "Estas seguro de que quieres eliminar este reporte", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: { (action : UIAlertAction!) in
            }))
            
            alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: { [self] (action : UIAlertAction!) in
                self.db.collection("reporte").document(listaReportes[indexPath.row].key).updateData(["terminado": true])
                self.listaReportes.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }))
            
            present(alert, animated: true, completion: nil)
            
            // Delete the row from the data source
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueAgregarReporte"){
            let agregarView = segue.destination as! AgregarReporteView
            
            agregarView.delegate = self
            agregarView.listaReportes = listaReportes
        }
        else {
            let detailView = segue.destination as! VerReporteView
            let index = tableView.indexPathForSelectedRow!
            
            detailView.reporte = listaReportes[index.row]
            detailView.delegate = self
            detailView.index = index.row
        }
    }
    
    func agregarReporte(listaReporte: [Reporte]) {
        listaReportes = listaReporte
        tableView.reloadData()
    }
    
    func completarReporte(index: Int, nombre: String) {
        listaReportes.remove(at: index)
        tableView.reloadData()
    }
    
    func actualizarReporte(index: Int, reporte: Reporte) {
        listaReportes[index] = reporte
        tableView.reloadData()
    }
    
    @IBAction func unwindReporteView (segue: UIStoryboardSegue){
        
    }
}
