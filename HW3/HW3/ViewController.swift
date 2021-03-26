//
//  ViewController.swift
//  HW3
//
//  Created by Ricardo López Canales on 25/03/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tfLabelOperacion: UILabel!
    @IBOutlet var tfLabelResultado: UILabel!
    @IBOutlet var tfImage: UIImageView!
    
    @IBOutlet weak var viewResults: UIView!
    
    var colorVw : UIColor!
    
    var imageOp : UIImage!
    
    var operacion : String!
    
    var resultado : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func unwindEsfera(segue: UIStoryboardSegue){
        tfLabelOperacion.text =  operacion
        tfLabelResultado.text = resultado
        tfImage.image = imageOp
        
        self.viewResults.backgroundColor = colorVw
        
    }
     /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Esfera"{
            let viewEsfer = segue.destination as! ViewControllerEsfera
            viewEsfer.
        } else if segue.identifier == "Prisma"{
            let viewPrism = segue.destination as! ViewControllerPrisma
        } else {
            let viewSettings = segue.destination as! ViewControllerSettings
        }
    */


}

