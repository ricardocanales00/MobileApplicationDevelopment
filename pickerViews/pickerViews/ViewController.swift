//
//  ViewController.swift
//  pickerViews
//
//  Created by Ricardo López Canales on 13/05/21.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var dataPick: UIPickerView!
    var listaImagenes = [UIImage(systemName: "pencil"),
                         UIImage(systemName: "folder"),
                         UIImage(systemName: "calendar"),
                         UIImage(systemName: "book"),
                         UIImage(systemName: "ticket")]
    
    var listaImagenes2 = ["pencil",
                         "folder",
                         "calendar",
                         "book",
                         "ticket"]
    
    var selected : UIImage = UIImage(named: "pencil")!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
           myImageView.image = listaImagenes[row]
           return myImageView
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listaImagenes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = listaImagenes[row]!
        self.performSegue(withIdentifier: "seeImage", sender: self)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seeImage" {
            let viewFoto = segue.destination as! ViewControllerScnd
            viewFoto.foto = selected
        }
    }


}

