//
//  ViewController.swift
//  ClassActivityPersistencia
//
//  Created by Ricardo López Canales on 16/04/21.
//

import UIKit

    



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tfNum1: UITextField!
    @IBOutlet weak var tfNum2: UITextField!
    @IBOutlet weak var tableVw: UITableView!
    @IBOutlet weak var lbNombre: UILabel!
    
    var listaCoordenadas = [Coordenada]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let app = UIApplication.shared
        
        NotificationCenter.default.addObserver(self, selector: #selector(guardarCoordenadas), name: UIApplication.didEnterBackgroundNotification, object: app)
        
        if FileManager.default.fileExists(atPath: dataFileURL().path){
            obtenerCoordenadas()
        }
    }
    
    func dataFileURL() -> URL{
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = documentsDirectory.appendingPathComponent("Coordenada").appendingPathExtension("plist")
        print(pathArchivo.path)
        return pathArchivo
    }
    
    // Métodos de data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaCoordenadas.count
    }
    
    //MARK: Instance Methods
    
    @IBAction func agregarCoordenada(_ sender: UIButton) {
        let coorden = Coordenada(Numero1: Int(tfNum1.text!)!, Numero2: Int(tfNum2.text!)! )
        
        listaCoordenadas.append(coorden)
        tableVw.reloadData()

    }
    
    
    @IBAction func guardarCoordenadas(){
        do {
            let data = try PropertyListEncoder().encode(listaCoordenadas)
            try data.write(to: dataFileURL())
        }
        catch {
            print("Error al guardar los datos")
        }
    }
    
    func obtenerCoordenadas(){
        do{
            let data = try Data.init(contentsOf: dataFileURL())
            listaCoordenadas = try PropertyListDecoder().decode([Coordenada].self, from: data)
        }
        catch{
            print("Error al cargar los datos del archivo")
        }
        tableVw.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda")!
        
        var num1 = String(listaCoordenadas[indexPath.row].Numero1)
        var num2 = String(listaCoordenadas[indexPath.row].Numero2)
        cell.textLabel?.text = """
                            (\(num1),\(num2))
                            """
        return cell
    }
    
    func actualizarSettings(){
        let defaults = UserDefaults.standard
        
        if let nombr = defaults.value(forKey: "nombre") as? String{
            lbNombre.text = nombr
        }
        let size = defaults.integer(forKey: "tamano")
        
        let booleano = defaults.bool(forKey: "color")
        
    }


}

