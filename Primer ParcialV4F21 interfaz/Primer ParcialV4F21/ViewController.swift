//
//  ViewController.swift
//  Primer ParcialV4F21
//
//  Created by Yolanda Martínez Treviño on 23/03/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segImage: UISegmentedControl!
    @IBOutlet var checkImage: UIImageView!
    @IBOutlet var bigSmall: UIImageView!
    @IBOutlet var purpleView: UIView!
    
    //Segue
    @IBOutlet var lbDato1: UITextField!
    @IBOutlet var lbDato2: UITextField!
    @IBOutlet var lbResultado: UILabel!
    var dato1 : String!
    var dato2 : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(resize))
        purpleView.addGestureRecognizer(tap);
    }
    
    //Parte Azul
    @IBAction func pickSelection(_ sender: UISegmentedControl) {
        switch segImage.selectedSegmentIndex {
        case 0:
            checkImage.image = UIImage(named:"check")
        case 1:
            checkImage.image = UIImage(named:"unchecked")
        default:
            break;
        }
        
    }
    
    @IBAction func resize(){
        //aqui se cambian las medidas de la imagen
        bigSmall.image = UIImage(named: "check")
    }
    
    
    //Parte Rosa
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewOp = segue.destination as! ViewControllerOperacionViewController
        viewOp.Sdato1 = lbDato1.text!
        viewOp.Sdato2 = lbDato2.text!
    }
    
    func unwindOpe(segue : UIStoryboardSegue){
        lbResultado.text = resultado1!
    }
    
}

