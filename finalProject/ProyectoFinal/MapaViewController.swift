//
//  MapaViewController.swift
//  ProyectoFinal
//
//  Created by Alex Vasquez on 5/1/21.
//

import UIKit

class MapaViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var btnParqie: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var labelHola: UILabel!
    @IBOutlet weak var btn3: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnParqie.layer.cornerRadius = 10
        
        btn1.layer.cornerRadius = 10
        btn2.layer.cornerRadius = 10
        btn3.layer.cornerRadius = 10
        
        if let nombre = UserDefaults.standard.string(forKey: "usuario"){
            labelHola.text = nombre + "!"
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }

    override var shouldAutorotate: Bool {
        return false
    }
    
    /* Funcion para permitir zoom
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return vistaFoto
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
