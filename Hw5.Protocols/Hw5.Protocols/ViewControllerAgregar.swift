//
//  ViewControllerAgregar.swift
//  Hw5.Protocols
//
//  Created by Ricardo López Canales on 9/04/21.
//

import UIKit

protocol protocoloAgregarClima {
    func agregarClima(clim: Clima)
}


class ViewControllerAgregar: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var tfNombre: UITextField!
    @IBOutlet weak var tfGrados: UITextField!
    
    var delegado : protocoloAgregarClima!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func agregarClima(_ sender: UIButton) {
        var clima = Clima(nombre: tfNombre.text!, grados: Int(tfGrados.text!)!, foto: imgFoto.image)
        delegado.agregarClima(clim: clima)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func agregarFoto(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: -Metodos de delegado
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let foto = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imgFoto.image = foto
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
