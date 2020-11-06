//
//  TableViewCell.swift
//  PoetryLab!
//
//  Created by Bernbel Aguilar on 25/09/20.
//

import UIKit

class TableViewCell: UITableViewCell {

   
   @IBOutlet weak var imageCell: UIImageView!
   @IBOutlet weak var label1Cell: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
