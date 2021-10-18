//
//  C_CommTableViewCell.swift
//  health
//
//  Created by Songjeongpyeong on 2021/10/17.
//

import UIKit

class C_CommTableViewCell: UITableViewCell {

    @IBOutlet weak var img_comm: UIImageView!
    @IBOutlet weak var lbl_id_comm: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
       
        // 이미지 둥글게
        img_comm.layer.cornerRadius = 15
        img_comm.clipsToBounds = true
        img_comm.layer.cornerRadius = img_comm.frame.size.width / 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
