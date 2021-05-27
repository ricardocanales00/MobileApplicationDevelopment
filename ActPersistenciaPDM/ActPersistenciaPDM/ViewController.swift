//
//  ViewController.swift
//  ActPersistenciaPDM
//
//  Created by Ricardo López Canales on 06/05/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var listaCoordenada = [Coordenada]()
    
    var nombre : String = ""
    var sizeCell : Int = 0
    var backgrd : Bool = false
    
    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var tfCoor1: UITextField!
    @IBOutlet weak var tfCoor2: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let app = UIApplication.shared
        
        NotificationCenter.default.addObserver(self, selector: #selector(guardarCoor), name: UIApplication.didEnterBackgroundNotification, object: app)
        
        if FileManager.default.fileExists(atPath: dataFileURL().path){
            getCoor()
        }
    }
    
    // MARK: - Persistencia
    
    @IBAction func nuevaCoordenada(_ sender: Any) {
        let help = Coordenada(num1: Int(tfCoor1.text!)!, num2: Int(tfCoor2.text!)!)
        
        listaCoordenada.append(help)
        tableView.reloadData()
    }
    
    
    func dataFileURL() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = documentsDirectory.appendingPathComponent("Coordenadas").appendingPathExtension("plist")
        return pathArchivo
    }
    
    @IBAction func guardarCoor(){
        do {
            let data = try PropertyListEncoder().encode(listaCoordenada)
            try data.write(to: dataFileURL())
        }
        catch {
            print("No se guardaron los archivos")
        }
    }
    
    func getCoor(){
        do{
            let data = try Data.init(contentsOf: dataFileURL())
            listaCoordenada = try PropertyListDecoder().decode([Coordenada].self, from: data)
        }
        catch{
            print("No fue posible cargar la información")
        }
        tableView.reloadData()
    }
    
    
// MARK: - Table View
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaCoordenada.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda")!
        cell.textLabel?.text = " (\(String(listaCoordenada[indexPath.row].num1)), \(String(listaCoordenada[indexPath.row].num2)))"
        return cell
    }
    
    func confi(){
        let defaults = UserDefaults.standard
        
        if let nombr = defaults.value(forKey: "nombre") as? String{
            lbNombre.text = nombr
            nombre = nombr
        }
        let size = defaults.integer(forKey: "sizeCell")
        sizeCell = size
        
        switch size {
        case 0:
            tableView.rowHeight = 50
        case 1:
            tableView.rowHeight = 80
        case 2:
            tableView.rowHeight = 100
        default:
            tableView.rowHeight = 50
        }

        let backyes = defaults.bool(forKey: "backgrd")
        backgrd = backyes
        
        if backyes  == true {
            tableView.backgroundColor = UIColor.red
        }
    }
    
    @IBAction func guardaConfig(){
        let defaults = UserDefaults.standard
        
        if let nombre = lbNombre.text {
            defaults.setValue(nombre, forKey: "nombre")
        }
        defaults.set(sizeCell, forKey: "sizeCell")
        defaults.set(backgrd, forKey: "backgrd")
    }


}

