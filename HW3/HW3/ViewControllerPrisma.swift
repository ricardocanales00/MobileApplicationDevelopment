//
//  ViewControllerPrisma.swift
//  HW3
//
//  Created by Ricardo López Canales on 25/03/21.
//

import UIKit

class ViewControllerPrisma: UIViewController {
    
    
    @IBOutlet weak var imgPrisma: UIImageView!
    @IBOutlet weak var tfDimension1: UITextField!
    @IBOutlet weak var tfDimension2: UITextField!
    @IBOutlet weak var tfDimension3: UITextField!
    @IBOutlet weak var btArea: UIButton!
    @IBOutlet weak var btVolumen: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if tfDimension1.text! == "" || tfDimension2.text! == "" || tfDimension3.text! == "" {
            let alerta = UIAlertController(title: "Error", message: "Ingresa todas las medidas", preferredStyle: .alert)
            let accion = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alerta.addAction(accion)
            present(alerta, animated: true, completion: nil)
            return false
        } else {
            return true
        }
    }

    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let mainView = segue.destination as! ViewController
        
        if (sender as! UIButton) == btArea{
            if let ancho = Double(tfDimension1.text!), let largo = Double(tfDimension2.text!), let altura = Double(tfDimension3.text!) {
                let result  = 2 * altura * (largo + ancho) + (2 * largo * ancho)
                mainView.resultado = """
                                    Base = \(tfDimension1.text!)
                                    Ancho = \(tfDimension2.text!)
                                    Altura = \(tfDimension3.text!)
                                    Area = \(result)
                                    """
                mainView.operacion = "Área de un prisma"
                mainView.imageOp = imgPrisma.image!
            }
        } else if (sender as! UIButton) == btVolumen{
            if let ancho = Double(tfDimension1.text!), let largo = Double(tfDimension2.text!), let altura = Double(tfDimension3.text!) {
                let result  = altura * largo * ancho
                mainView.resultado = """
                                    Base = \(tfDimension1.text!)
                                    Ancho = \(tfDimension2.text!)
                                    Altura = \(tfDimension3.text!)
                                    Volumen = \(result)
                                    """
                mainView.operacion = "Volumen de un prisma"
                mainView.imageOp = imgPrisma.image!
            }
        }
    }

}
