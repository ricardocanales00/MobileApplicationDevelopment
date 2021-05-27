//
//  EditarReporteViewController.swift
//  ProyectoFinal
//
//  Created by Alex Vasquez on 5/3/21.
//

import UIKit

protocol protocoloEditarReporte {
    func actualizarInformacion(reporteEdit: Reporte)
}

class EditarReporteViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var nombreTF: UITextField!
    @IBOutlet weak var lugarTF: UITextField!
    @IBOutlet weak var lugar2TF: UITextField!
    @IBOutlet weak var descripcionTF: UITextField!
    @IBOutlet weak var prioridadSlider: UISlider!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var vistaSuperior: UIView!
    
    var delegate : protocoloEditarReporte!
    
    let lugarPickerData = ["-", "Áreas Verdes", "Luminarias", "Islas Jardineria", "Estaciones"]
    
    var reporteInicial : Reporte!

    override func viewDidLoad() {
        super.viewDidLoad()
        let lugarPicker = UIPickerView()
        lugarPicker.tag = 1
        
        lugarPicker.delegate = self
        
        lugarTF.inputView = lugarPicker
        
        
        // Inicializar variables en base a reporte a editar
        imagen.image = reporteInicial.imagen
        nombreTF.text = reporteInicial.nombre
        
        let lugar = reporteInicial.lugar
        let lugarArr = lugar.components(separatedBy: "-")
        lugarTF.text = lugarArr[0]
        lugar2TF.text = lugarArr[1]
        
        descripcionTF.text = reporteInicial.descripcion
        
        scrollView.contentSize = vistaSuperior.frame.size

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelarEdit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    */
    
    @IBAction func agregarFoto(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Metodos de delegado de UIImage Picker Controller
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let foto = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imagen.image = foto
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func removeKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    @IBAction func actualizarInfo(_ sender: Any) {
        if (nombreTF.text != "" && lugarTF.text != ""  && lugarTF.text != "-" && lugar2TF.text != ""){
            let reporteEditado = Reporte(nombre: nombreTF.text!, lugar: lugarTF.text! + "-" + lugar2TF.text!, fecha: reporteInicial.fecha, descripcion: descripcionTF.text!, prioridad: Double(prioridadSlider.value), imagen: imagen.image!, key: reporteInicial.key)
            
            delegate.actualizarInformacion(reporteEdit: reporteEditado)
            dismiss(animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Campos Incompletos", message: "Debes de llenar todos los campos requeridos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func mostrarMapas(_ sender: Any) {
        if (lugarTF.text == "Áreas Verdes"){
            performSegue(withIdentifier: "areasvedit", sender: self)
        }
        else if (lugarTF.text == "Luminarias"){
            performSegue(withIdentifier: "luminariasedit", sender: self)
        }
        else if (lugarTF.text == "Islas Jardineria"){
            performSegue(withIdentifier: "islasedit", sender: self)
        }
        else if (lugarTF.text == "Estaciones"){
            performSegue(withIdentifier: "estacionesedit", sender: self)
        }
        else {
            let alert = UIAlertController(title: "Campo Incompleto", message: "Debes de seleccionar un tipo de lugar para mostrar el mapa", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
}
