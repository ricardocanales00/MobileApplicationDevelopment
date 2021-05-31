//
//  ubicacionViewController.swift
//  ProyectoFinal
//
//  Created by Alex Vasquez on 5/28/21.
//

import UIKit
import MapKit

class ubicacionViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var coordenada : CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let coordinate = CLLocationCoordinate2D(latitude: coordenada.latitude, longitude: coordenada.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated:true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
        
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }

    override var shouldAutorotate: Bool {
        return false
    }
}
