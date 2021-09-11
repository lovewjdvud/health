//
//  C_AddGroupTableViewCell.swift
//  health
//
//  Created by Songjeongpyeong on 2021/09/02.
//

import UIKit




class C_AddGroupTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lbl_group_title: UILabel!
    
    @IBOutlet weak var lbl_group_number: UILabel!
  
    
    @IBOutlet weak var lbl_group_finshday: UILabel!
    @IBOutlet weak var lbl_group_lastDay: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
     
       // test.layer.cornerRadius = 10 // 버튼 모서리 깍기
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  
    
    
}
