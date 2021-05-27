//
//  MapaEstacionesViewController.swift
//  ProyectoFinal
//
//  Created by Alex Vasquez on 5/23/21.
//

import UIKit

class MapaEstacionesViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var vistaFoto : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vistaFoto = UIImageView(image: UIImage(named: "estaciones")!)
        scrollView.addSubview(vistaFoto)
        scrollView.contentSize = vistaFoto.frame.size
        scrollView.contentOffset = CGPoint(x: 500, y: 1000)
        scrollView.zoomScale = 0.2
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
