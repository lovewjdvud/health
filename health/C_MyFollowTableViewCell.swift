//
//  C_MyFollowTableViewCell.swift
//  health
//
//  Created by Songjeongpyeong on 2021/10/19.
//

import UIKit

class C_MyFollowTableViewCell: UITableViewCell {

    @IBOutlet weak var img_my_follow: UIImageView!
    
    @IBOutlet weak var lbl_id_myCell: UILabel!
    @IBOutlet weak var lbl_name_myCell: UILabel!
    
    @IBOutlet weak var btn_follow_myCell: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
           // 이미지 깍기
        img_my_follow.layer.cornerRadius = 13
        img_my_follow.clipsToBounds = true
           
   //        middleButton.clipsToBounds = true
        img_my_follow.layer.cornerRadius = img_my_follow.frame.size.width / 2
    }

    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
