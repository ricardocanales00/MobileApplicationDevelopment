//
//  AgregarReporteView.swift
//  ProyectoFinal
//
//  Created by Alex Vasquez on 5/1/21.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseFirestore
import FirebaseStorage

protocol protocoloAgregarReporte {
    func agregarReporte(listaReporte: [Reporte])
}

class AgregarReporteView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage().reference()
    
    @IBOutlet weak var nombreTF: UITextField!
    @IBOutlet weak var lugarTF: UITextField!
    @IBOutlet weak var lugar2TF: UITextField!
    @IBOutlet weak var fechaTF: UITextField!
    @IBOutlet weak var descripcionTF: UITextView!
    @IBOutlet weak var prioridadSlider: UISlider!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var vistaSuperior: UIView!
    
    @IBOutlet weak var mapView: MKMapView!
    let manager = CLLocationManager()
    
    let lugarPickerData = ["-", "Áreas Verdes", "Luminarias", "Islas Jardineria", "Estaciones"]
    
    var listaReportes = [Reporte]()
    var delegate : protocoloAgregarReporte!
    var coordinate : CLLocationCoordinate2D!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lugarPicker = UIPickerView()
        lugarPicker.tag = 1
        
        lugarPicker.delegate = self
        
        lugarTF.inputView = lugarPicker
        
        fechaTF.text = convertDateFormatter()
        
        scrollView.contentSize = vistaSuperior.frame.size

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Metodos para obtener la current location del usuario
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            
            render(location)
        }
    }
    
    func render(_ location: CLLocation){
        self.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
    

    @IBAction func agregarReporte(_ sender: Any) {
        
        if (nombreTF.text != "" && lugarTF.text != "" && descripcionTF.text != "-" && lugar2TF.text != ""){
            let ref = self.db.collection("reporte").addDocument(data: ["nombre": nombreTF.text! , "terminado": false , "lugar" : String(lugarTF.text! + "-" + lugar2TF.text!), "descripcion" : descripcionTF.text, "fecha" : fechaTF.text!, "prioridad": prioridadSlider.value, "latitud" : coordinate.latitude, "longitud" : coordinate.longitude])

            
            dismiss(animated: true, completion: nil)
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
        return lugarPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return lugarPickerData[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lugarTF.text = lugarPickerData[row]
    }
    
    func convertDateFormatter() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        let result = formatter.string(from: date)
        return result
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
    @IBAction func agregarFoto(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Metodos de delegado de UIImage Picker Controller
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let foto = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func removeKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    @IBAction func ejecutaSegueMapas(_ sender: Any) {
        if (lugarTF.text == "Áreas Verdes"){
            performSegue(withIdentifier: "areasv", sender: self)
        }
        else if (lugarTF.text == "Luminarias"){
            performSegue(withIdentifier: "luminarias", sender: self)
        }
        else if (lugarTF.text == "Islas Jardineria"){
            performSegue(withIdentifier: "islas", sender: self)
        }
        else if (lugarTF.text == "Estaciones"){
            performSegue(withIdentifier: "estaciones", sender: self)
        }
        else {
            let alert = UIAlertController(title: "Campo Incompleto", message: "Debes de seleccionar un tipo de lugar para mostrar el mapa", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }

    override var shouldAutorotate: Bool {
        return false
    }
}
