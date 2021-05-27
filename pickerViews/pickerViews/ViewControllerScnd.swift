//
//  ViewControllerScnd.swift
//  pickerViews
//
//  Created by Ricardo López Canales on 13/05/21.
//

import UIKit

class ViewControllerScnd: UIViewController {
    
    var foto : UIImage!
    
    @IBOutlet var imgSelected: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgSelected.image = foto

        // Do any additional setup after loading the view.
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
