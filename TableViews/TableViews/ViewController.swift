//
//  ViewController.swift
//  TableViews
//
//  Created by Ricardo López Canales on 06/04/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var listaApps = [
        App(nombre: "Facebook", foto: UIImage(named: "fb")),
        App(nombre: "Twitter", foto: UIImage(named: "tw")),
        App(nombre: "Instagram", foto: UIImage(named: "ig")),
        App(nombre: "Pinterest", foto: UIImage(named: "pt")),
        App(nombre: "Tumblr", foto: UIImage(named: "tb")),
        App(nombre: "Whatsapp", foto: UIImage(named: "wa"))
    ]
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title =  "Social Media Apps"
    }

    //Metodos de data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaApps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celda")!
        celda.textLabel?.text = listaApps[indexPath.row].nombre
        celda.imageView?.image = listaApps[indexPath.row].foto!
        return celda
    }
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let details = segue.destination as! ViewControllerDetails
        
        let index = tableView.indexPathForSelectedRow!
        details.eachApp = listaApps[index.row]
    }
}

