//
//  CustomTableViewCell.swift
//  Hw5.Protocols
//
//  Created by Ricardo López Canales on 9/04/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbNombre: UILabel!
    @IBOutlet weak var lbGrados: UILabel!
    @IBOutlet weak var imgFoto: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
