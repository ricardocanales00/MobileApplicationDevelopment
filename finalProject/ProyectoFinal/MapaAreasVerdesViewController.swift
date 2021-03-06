//
//  MapaAreasVerdesViewController.swift
//  ProyectoFinal
//
//  Created by Alex Vasquez on 5/23/21.
//

import UIKit

class MapaAreasVerdesViewController: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    var vistaFoto : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vistaFoto = UIImageView(image: UIImage(named: "areasverdes")!)
        scrollView.addSubview(vistaFoto)
        scrollView.contentSize = vistaFoto.frame.size
        scrollView.contentOffset = CGPoint(x: 500, y: 1000)
        scrollView.zoomScale = 0.2
    }
    
    // Funcion para permitir zoom
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return vistaFoto
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }

    override var shouldAutorotate: Bool {
        return false
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
