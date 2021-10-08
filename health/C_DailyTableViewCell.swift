//
//  C_DailyTableViewCell.swift
//  health
//
//  Created by Songjeongpyeong on 2021/10/04.
//

import UIKit

class C_DailyTableViewCell: UITableViewCell {

    
    @IBOutlet weak var img_id_CD: UIImageView!
    @IBOutlet weak var lbl_id_CD: UILabel!
    @IBOutlet weak var lbl_write_CD: UILabel!
    @IBOutlet weak var lbl_tag_CD: UILabel!
    @IBOutlet weak var img_upload_CD: UIImageView!
    @IBOutlet weak var lbl_date_CD: UILabel!
    @IBOutlet weak var lbl_likecount_CD: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        img_id_CD.layer.cornerRadius = 15
        img_id_CD.clipsToBounds = true
        
//        middleButton.clipsToBounds = true
        img_id_CD.layer.cornerRadius = img_id_CD.frame.size.width / 2

        
        
        
        
    }

    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    
    

}
