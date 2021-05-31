//
//  ViewController.swift
//  ProyectoFinal
//
//  Created by Alex Vasquez on 5/1/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var iniciarSesionBtn: UIButton!
    
    
    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "parque1.png")
            imageView.contentMode = .scaleToFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.insertSubview(imageView, at: 0)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        iniciarSesionBtn.layer.cornerRadius = 8
        
        let layerGradient = CAGradientLayer()
        
        layerGradient.frame = view.bounds
        layerGradient.opacity = 0.8
        layerGradient.colors = [UIColor(red: 231/255, green: 82/255, blue: 93/255, alpha: 1).cgColor, UIColor(red: 126/255, green: 75/255, blue: 126/255, alpha: 1).cgColor]

        view.layer.insertSublayer(layerGradient, at: 1)
    }

    
    
    @IBAction func undwindRegistro (segue: UIStoryboardSegue){
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }

    override var shouldAutorotate: Bool {
        return false
    }

}

