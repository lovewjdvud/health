//
//  C_memenAddTableViewCell.swift
//  health
//
//  Created by Songjeongpyeong on 2021/09/09.
//

import UIKit

class C_memenAddTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var img_memberAdd: UIImageView!
  
    @IBOutlet weak var lbl_id_memberAdd: UILabel!
    @IBOutlet weak var lbl_name_memberAdd: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        img_memberAdd.layer.cornerRadius = 39.6
        img_memberAdd.clipsToBounds = true
    }

    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
