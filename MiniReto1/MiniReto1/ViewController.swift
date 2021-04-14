//
//  ViewController.swift
//  MiniReto1
//
//  Created by Ricardo López Canales on 05/04/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgDado1: UIImageView!
    @IBOutlet weak var imgDado2: UIImageView!
    
    @IBOutlet weak var lbResl2: UILabel!
    @IBOutlet weak var lbResl3: UILabel!
    @IBOutlet weak var lbResl4: UILabel!
    @IBOutlet weak var lbResl5: UILabel!
    @IBOutlet weak var lbResl6: UILabel!
    @IBOutlet weak var lbResl7: UILabel!
    @IBOutlet weak var lbResl8: UILabel!
    @IBOutlet weak var lbResl9: UILabel!
    @IBOutlet weak var lbResl10: UILabel!
    @IBOutlet weak var lbResl11: UILabel!
    @IBOutlet weak var lbResl12: UILabel!
    
    @IBOutlet weak var prResl2: UIProgressView!
    @IBOutlet weak var prResl3: UIProgressView!
    @IBOutlet weak var prResl4: UIProgressView!
    @IBOutlet weak var prResl5: UIProgressView!
    @IBOutlet weak var prResl6: UIProgressView!
    @IBOutlet weak var prResl7: UIProgressView!
    @IBOutlet weak var prResl8: UIProgressView!
    @IBOutlet weak var prResl9: UIProgressView!
    @IBOutlet weak var prResl10: UIProgressView!
    @IBOutlet weak var prResl11: UIProgressView!
    @IBOutlet weak var prResl12: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func lanzarDados(_ sender: UIButton) {
        let dado1 = Int.random(in: 1..<7)
        let dado2 = Int.random(in: 1..<7)
        
        switch dado1 {
            case 1:
                imgDado1.image = UIImage(named: "1")
            case 2:
                imgDado1.image = UIImage(named: "2")
            case 3:
                imgDado1.image = UIImage(named: "3")
            case 4:
                imgDado1.image = UIImage(named: "4")
            case 5:
                imgDado1.image = UIImage(named: "5")
            case 6:
                imgDado1.image = UIImage(named: "6")
            default:
                break
        }
        
        switch dado2 {
            case 1:
                imgDado2.image = UIImage(named: "1")
            case 2:
                imgDado2.image = UIImage(named: "2")
            case 3:
                imgDado2.image = UIImage(named: "3")
            case 4:
                imgDado2.image = UIImage(named: "4")
            case 5:
                imgDado2.image = UIImage(named: "5")
            case 6:
                imgDado2.image = UIImage(named: "6")
            default:
                break
        }
        
        let suma = Int(dado1) + Int(dado2)
        
        switch suma {
        case 2:
            var temp = Int(lbResl2.text!)!
            temp = temp + 1
            lbResl2.text = String(temp)
            prResl2.progress = prResl2.progress + 0.02
        case 3:
            var temp = Int(lbResl3.text!)!
            temp = temp + 1
            lbResl3.text = String(temp)
            prResl3.progress = prResl3.progress + 0.02
        case 4:
            var temp = Int(lbResl4.text!)!
            temp = temp + 1
            lbResl4.text = String(temp)
            prResl4.progress = prResl4.progress + 0.02
        case 5:
            var temp = Int(lbResl5.text!)!
            temp = temp + 1
            lbResl5.text = String(temp)
            prResl5.progress = prResl5.progress + 0.02
        case 6:
            var temp = Int(lbResl6.text!)!
            temp = temp + 1
            lbResl6.text = String(temp)
            prResl6.progress = prResl6.progress + 0.02
        case 7:
            var temp = Int(lbResl7.text!)!
            temp = temp + 1
            lbResl7.text = String(temp)
            prResl7.progress = prResl7.progress + 0.02
        case 8:
            var temp = Int(lbResl8.text!)!
            temp = temp + 1
            lbResl8.text = String(temp)
            prResl8.progress = prResl8.progress + 0.02
        case 9:
            var temp = Int(lbResl9.text!)!
            temp = temp + 1
            lbResl9.text = String(temp)
            prResl9.progress = prResl9.progress + 0.02
        case 10:
            var temp = Int(lbResl10.text!)!
            temp = temp + 1
            lbResl10.text = String(temp)
            prResl10.progress = prResl10.progress + 0.02
        case 11:
            var temp = Int(lbResl11.text!)!
            temp = temp + 1
            lbResl11.text = String(temp)
            prResl11.progress = prResl11.progress + 0.02
        case 12:
            var temp = Int(lbResl12.text!)!
            temp = temp + 1
            lbResl12.text = String(temp)
            prResl12.progress = prResl12.progress + 0.02
        default:
            break
        }
    }
    
}

