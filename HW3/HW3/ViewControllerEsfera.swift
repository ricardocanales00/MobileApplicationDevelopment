//
//  ViewControllerEsfera.swift
//  HW3
//
//  Created by Ricardo López Canales on 25/03/21.
//

import UIKit

class ViewControllerEsfera: UIViewController {
    
    @IBOutlet var tfRadio: UITextField!
    var radio : Double!
    @IBOutlet var btArea: UIButton!
    @IBOutlet var btVolume: UIButton!
    @IBOutlet var imgFoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if tfRadio.text! == "" {
            let alerta = UIAlertController(title: "Error", message: "Ingresa el dato del radio", preferredStyle: .alert)
            let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alerta.addAction(accion)
            present(alerta, animated: true, completion: nil)
            return false
        } else {
            return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let mainView = segue.destination as! ViewController
        
        if (sender as! UIButton) == btArea{
            if let radius = Double(tfRadio.text!){
                let result  = 4 * 3.1416 * radius * radius
                mainView.resultado = """
                                    Radio = \(tfRadio.text!)
                                    Area = \(result)
                                    """
                mainView.operacion = "Área de una esfera"
                mainView.imageOp = imgFoto.image!
            }
        } else if (sender as! UIButton) == btVolume{
            if let radius = Double(tfRadio.text!){
                let result  = 4 / 3 * 3.1416 * radius * radius * radius
                mainView.resultado = """
                                    Radio = \(tfRadio.text!)
                                    Volumen = \(result)
                                    """
                mainView.operacion = "Volumen de una esfera"
                mainView.imageOp = imgFoto.image!
            }
        }
    }

}
