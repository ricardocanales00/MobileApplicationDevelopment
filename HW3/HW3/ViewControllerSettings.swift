//
//  ViewControllerSettings.swift
//  HW3
//
//  Created by Ricardo López Canales on 25/03/21.
//

import UIKit

class ViewControllerSettings: UIViewController {
    @IBOutlet weak var btColor1: UIButton!
    @IBOutlet weak var btnColor2: UIButton!
    @IBOutlet weak var btnColor3: UIButton!
    @IBOutlet weak var btnColor4: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let mainView = segue.destination as! ViewController
        
        if (sender as! UIButton) == btColor1 {
            mainView.colorVw = UIColor.green
        } else if (sender as! UIButton) == btnColor2 {
            mainView.colorVw = UIColor.orange
        } else if (sender as! UIButton) == btnColor3 {
            mainView.colorVw = UIColor.blue
        } else {
            mainView.colorVw = UIColor.purple
        }
    }
}
