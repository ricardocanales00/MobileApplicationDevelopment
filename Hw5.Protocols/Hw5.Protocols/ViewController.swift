//
//  ViewController.swift
//  Hw5.Protocols
//
//  Created by Ricardo López Canales on 9/04/21.
//

import UIKit

class ViewController: UIViewController {
    
    var unClima : Clima!
    
    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var imgNombre: UILabel!
    @IBOutlet weak var imgGrados: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Detalle clima"
        imgFoto.image = unClima.foto
        imgNombre.text = unClima.nombre
        imgGrados.text = String(unClima.grados)
    }


}

