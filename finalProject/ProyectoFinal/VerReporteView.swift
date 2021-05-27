//
//  VerReporteView.swift
//  ProyectoFinal
//
//  Created by Alex Vasquez on 5/1/21.
//

import UIKit
import MapKit

protocol protocoloCompletarReporte {
    func completarReporte(index: Int, nombre: String)
    func actualizarReporte(index: Int, reporte: Reporte)
}

class VerReporteView: UIViewController, protocoloEditarReporte {
    
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var lugarLabel: UILabel!
    @IBOutlet weak var fechaLabel: UILabel!
    @IBOutlet weak var descripcionLabel: UITextView!
    @IBOutlet weak var prioridadLabel: UILabel!
    @IBOutlet weak var botonCompletar: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var reporte: Reporte!
    var delegate: protocoloCompletarReporte!
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        asignarCampos()
        // Do any additional setup after loading the view.
    }
    
    func mapMarker(_ location: CLLocation){
        let coordinate = CLLocationCoordinate2D(latitude: reporte.latitud, longitude: reporte.longitud)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
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
        
        else if (sender as! UIButton) == botonCompletar {
            
            let alert = UIAlertController(title: "Completar Reporte", message: "Estas seguro de que quieres marcas el reporte como completado", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: { (action : UIAlertAction!) in
            }))
            
            alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: { (action : UIAlertAction!) in
                self.completarReporte()
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
        imagen.image = reporte.imagen
        nombreLabel.text = "Nombre: " + reporte.nombre
        lugarLabel.text = "Lugar: " + reporte.lugar
        fechaLabel.text = "Fecha: " + reporte.fecha
        descripcionLabel.text = "Descripcion: " + reporte.descripcion
        prioridadLabel.text = "Prioridad: " + String(Int((reporte.prioridad * 10).rounded()))
    }
}
