//
//  ViewControllerDetails.swift
//  TableViews
//
//  Created by Ricardo López Canales on 06/04/21.
//

import UIKit

class ViewControllerDetails: UIViewController {
    
    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var lbNombre: UILabel!
    
    var eachApp : App!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imgFoto.image = eachApp.foto
        lbNombre.text = eachApp.nombre
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
