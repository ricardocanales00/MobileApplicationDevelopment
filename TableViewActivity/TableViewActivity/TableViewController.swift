//
//  TableViewController.swift
//  TableViewActivity
//
//  Created by Ricardo López Canales on 03/04/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    var listaApps = [
        app(nombre: "Facebook", foto: UIImage(named: "fb")),
        app(nombre: "Twitter", foto: UIImage(named: "tw")),
        app(nombre: "Instagram", foto: UIImage(named: "ig")),
        app(nombre: "Pinterest", foto: UIImage(named: "pt")),
        app(nombre: "Tumblr", foto: UIImage(named: "tb")),
        app(nombre: "Whatsapp", foto: UIImage(named: "wa"))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title =  "Social Media Apps"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaApps.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        
        cell.textLabel?.text = listaApps[indexPath.row].nombre
        cell.imageView?.image = listaApps[indexPath.row].foto!

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
            
            listaApps.remove(at: indexPath.row)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let temp = listaApps[fromIndexPath.row]
        listaApps[fromIndexPath.row] = listaApps[to.row]
        listaApps[to.row] = temp

    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let details = segue.destination as! ViewControllerDetails
        
        let index = tableView.indexPathForSelectedRow!
        details.eachApp = listaApps[index.row]
    }

}
