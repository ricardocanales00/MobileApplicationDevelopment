//
//  VerReporteView.swift
//  ProyectoFinal
//
//  Created by Alex Vasquez on 5/1/21.
//

import UIKit
import MapKit
import FirebaseFirestore
import FirebaseStorage

protocol protocoloCompletarReporte {
    func completarReporte(index: Int, nombre: String)
    func actualizarReporte(index: Int, reporte: Reporte)
}

class VerReporteView: UIViewController, protocoloEditarReporte {
    
    private let db = Firestore.firestore()
    let reporteCollectionRef = Firestore.firestore().collection("reporte")
    private let storage = Storage.storage().reference()
    
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var lugarLabel: UILabel!
    @IBOutlet weak var fechaLabel: UILabel!
    @IBOutlet weak var descripcionLabel: UITextView!
    @IBOutlet weak var prioridadLabel: UILabel!
    @IBOutlet weak var botonCompletar: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    
    var reporte: Reporte!
    var delegate: protocoloCompletarReporte!
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db.collection("reporte")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching collection: \(error!)")
                return
              }
                self.asignarCampos()
            }
        botonCompletar.setTitle("Completar Reporte", for: .normal)
    }

    override func viewWillAppear(_ animated: Bool) {
        asignarCampos()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editarReporteSegue"){
            let editarView = segue.destination as! EditarReporteViewController
            
            editarView.delegate = self
            editarView.reporteInicial = reporte
        }
        else if (segue.identifier == "ubicacion"){
            let ubiView = segue.destination as! ubicacionViewController
            
            ubiView.coordenada = CLLocationCoordinate2D(latitude: reporte.longitud, longitude: reporte.latitud)
        }
        
        else if (sender as! UIButton) == botonCompletar {
            
            let alert = UIAlertController(title: "Completar Reporte", message: "Estas seguro de que quieres marcas el reporte como completado", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: { (action : UIAlertAction!) in
            }))
            
            alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: { (action : UIAlertAction!) in
                self.db.collection("reporte").document(self.reporte.key).updateData(["terminado": true])
                //self.completarReporte()
                self.navigationController?.popViewController(animated: true)
            }))
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    func completarReporte() {
        delegate.completarReporte(index: index, nombre: reporte.nombre)
        navigationController?.popViewController(animated: true)
    }
    
    func actualizarInformacion(reporteEdit: Reporte) {
        reporte = reporteEdit
        asignarCampos()
        delegate.actualizarReporte(index: index, reporte: reporte)
    }
    
    func asignarCampos () {
        nombreLabel.text = reporte.nombre
        lugarLabel.text = "Lugar: " + reporte.lugar
        fechaLabel.text = "Fecha: " + reporte.fecha
        descripcionLabel.text = "Descripcion: " + reporte.descripcion
        prioridadLabel.text = "Prioridad: " + String(Int((reporte.prioridad * 10).rounded()))
    }
    
    func setButton() {
        view.addSubview(locationButton)
        locationButton.backgroundColor = .systemBlue
        locationButton.setTitle("Open location", for: .normal)
        locationButton.layer.cornerRadius = 8
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        locationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        locationButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        locationButton.widthAnchor.constraint(equalToConstant: 280).isActive = true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }

    override var shouldAutorotate: Bool {
        return false
    }
}
