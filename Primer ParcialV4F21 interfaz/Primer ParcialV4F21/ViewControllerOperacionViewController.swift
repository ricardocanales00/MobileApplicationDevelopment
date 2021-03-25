//
//  ViewControllerOperacionViewController.swift
//  Primer ParcialV4F21
//
//  Created by Ricardo López Canales on 24/03/21.
//

import UIKit

class ViewControllerOperacionViewController: UIViewController {
    @IBOutlet var dato1: UILabel!
    @IBOutlet var dato2: UILabel!
    
    
    @IBOutlet var resultado: UILabel!
    
    var Sdato1 : String!
    var Sdato2 : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dato1.text = Sdato1!
        dato2.text = Sdato2!
    }
    
    @IBAction func suma(_ sender: UIButton) {
        if let dat1 = Double(dato1.text!), let dat2 = Double(dato2.text!){
            let result = dat1 + dat2
            resultado.text = String(result)
        }
    }
    
    @IBAction func resta(_ sender: UIButton) {
        if let dat1 = Double(dato1.text!), let dat2 = Double(dato2.text!){
            let result = dat1 - dat2
            resultado.text = String(result)
            
        }
    }
    
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let vistainicial = segue.destination as! ViewController
        vistainicial.lbResultado = resultado.text!
    }
}
