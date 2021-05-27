//
//  MapaViewController.swift
//  ProyectoFinal
//
//  Created by Alex Vasquez on 5/1/21.
//

import UIKit

class MapaViewController: UIViewController, UIScrollViewDelegate {
    
    // Componentes
    @IBOutlet weak var mapaScroll: UIScrollView!
    var vistaFoto : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vistaFoto = UIImageView(image: UIImage(named: "plano")!)
        
        // Asignaciones del scrollview para colocar el plano
        mapaScroll.addSubview(vistaFoto)
        mapaScroll.contentSize = vistaFoto.frame.size
        mapaScroll.contentOffset = CGPoint(x: 500, y: 1000)
        mapaScroll.zoomScale = 0.3
    }
    
    // Funcion para permitir zoom
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return vistaFoto
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
