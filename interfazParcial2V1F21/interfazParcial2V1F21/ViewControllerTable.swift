//
//  ViewControllerTable.swift
//  interfazParcial2V1F21
//
//  Created by Ricardo López Canales on 06/05/21.
//

import UIKit

class ViewControllerTable: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lbNombre: UILabel!
    
    
    var label : String = ""
    var nextNumber : Int = 0
    var listaNumeros = [Numero]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let app = UIApplication.shared
        
        NotificationCenter.default.addObserver(self, selector: #selector(guardarNumeros), name: UIApplication.didEnterBackgroundNotification, object: app)
        
        if FileManager.default.fileExists(atPath: dataFileURL().path){
            obtenerNumeros()
        }
    }
    
    
    
    // MARK: - Persistencia
    
    @IBAction func agregarSiguiente(_ sender: UIButton) {
        let tempNum = Numero(numer: nextNumber)
        
        nextNumber = nextNumber + 1
        
        listaNumeros.append(tempNum)
        tableView.reloadData()
    }
    
    func dataFileURL() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = documentsDirectory.appendingPathComponent("Numeros").appendingPathExtension("plist")
        return pathArchivo
    }
    
    @IBAction func guardarNumeros(){
        do {
            let data = try PropertyListEncoder().encode(listaNumeros)
            try data.write(to: dataFileURL())
        }
        catch {
            print("Error al guardar los datos")
        }
    }
    
    func obtenerNumeros(){
        do{
            let data = try Data.init(contentsOf: dataFileURL())
            listaNumeros = try PropertyListDecoder().decode([Numero].self, from: data)
        }
        catch{
            print("Error al cargar los datos del archivo")
        }
        tableView.reloadData()
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaNumeros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda")!
        cell.textLabel?.text = String(listaNumeros[indexPath.row].numer)
        return cell
    }
    
    func actualizaConfig(){
        let defaults = UserDefaults.standard
        
        
        
        if let texto = defaults.value(forKey: "nombre") as? String{
            label = texto
        }
    }
    
    @IBAction func guardaConfig(){
        let defaults = UserDefaults.standard
        
        if let nombre = lbNombre.text {
            defaults.setValue(nombre, forKey: "nombre")
            
        }
    }
}
