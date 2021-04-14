//
//  TableViewController.swift
//  Hw5.Protocols
//
//  Created by Ricardo López Canales on 9/04/21.
//

import UIKit

class TableViewController: UITableViewController, protocoloAgregarClima {
    
    
    var listaClimas = [
        Clima(nombre: "Storm", grados: 15, foto: UIImage(named: "storm")),
        Clima(nombre: "Clouds", grados: 17, foto: UIImage(named: "clouds")),
        Clima(nombre: "Scatter", grados: 0, foto: UIImage(named: "scatter")),
        Clima(nombre: "Showers", grados: 18, foto: UIImage(named: "showers"))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        title = "Climas"
        self.navigationItem.leftBarButtonItem =  self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaClimas.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! CustomTableViewCell

        cell.lbNombre.text = listaClimas[indexPath.row].nombre
        cell.lbGrados.text = String(listaClimas[indexPath.row].grados)
        
        if let foto = listaClimas[indexPath.row].foto {
            cell.imgFoto.image = foto
        } else {
            cell.imgFoto.image = UIImage(named: "clear")
        }

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            listaClimas.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let temp = listaClimas[fromIndexPath.row]
        listaClimas[fromIndexPath.row] = listaClimas[to.row]
        listaClimas[to.row] = temp
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "mostrar" {
            let vistaDetalle = segue.destination as! ViewController
            let indice = tableView.indexPathForSelectedRow!
            vistaDetalle.unClima = listaClimas[indice.row]
        } else{
            let vistaAgregar = segue.destination as! ViewControllerAgregar
            vistaAgregar.delegado = self
            
        }
    }
    
    // MARK: - Metodos
    func agregarClima(clim: Clima) {
        listaClimas.append(clim)
        tableView.reloadData()
    }

}
