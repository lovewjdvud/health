//
//  C_FollowTableViewCell.swift
//  health
//
//  Created by Songjeongpyeong on 2021/09/06.
//

import UIKit
import Foundation

var test = [Int : String]()
var id_member = [Int :  String]()
var name_member = [Int : String]()
var img_member = [Int : String]()
var index_member: [Int] = []
var index_down = index_member.sorted(by: <)




protocol C_FollowProductCellDelegate {
    func btn_invite(index: Int ,invite_id: String,invite_name: String,invite_img: String)
}


class C_FollowTableViewCell: UITableViewCell {

  
   
    @IBOutlet weak var imgview_profileimg: UIImageView!
    @IBOutlet weak var lbl_idprofile: UILabel!
    @IBOutlet weak var lbl_nameprofile: UILabel!
    
    @IBOutlet weak var btn_invite: UIButton!
    var delegate2: EditDelegate?
   
    var index: Int!
    
    // 클릭시 받아 온값
    var invite_id = ""
    var invite_name = ""
    var invite_img = ""
    var invite_confirm = false
    var test_C = B_GFollowlist()
    // 클릭시 넣을 값
    var invite_id_array: [String] = []
    var invite_name_array: [String] = []
    var invite_img_array: [String] = []
    



    var delegate: C_FollowProductCellDelegate?
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        btn_invite.layer.cornerRadius = 10 // 버튼 모서리 깍기
        imgview_profileimg.layer.cornerRadius = 39.6
        imgview_profileimg.clipsToBounds = true
        
      
        
      //  setupMiddleButton()
    }
    
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func btn_gm_follow(_ sender: UIButton) {

        print("\(invite_id)  아이디값")
        print("\(invite_name)  이름값??")
        print("\(invite_img) 이미지값??")
    }
    
    
    // 초대 버튼
    @IBAction func btn_invite(_ sender: UIButton) {
       
       // self.delegate?.btn_invite(index: index, invite_id: invite_id, invite_name: invite_name, invite_img: invite_img)
       
        if invite_confirm == false {

            id_member.updateValue("\(invite_id)", forKey: index)
            name_member.updateValue("\(invite_name)", forKey: index)
            img_member.updateValue("\(invite_img)", forKey: index)
            index_member.append(index)
            print("\(invite_id) 여기는 팔로우팀")
         
            
            
            invite_confirm = true // 다시 바꿔주기
            
        } else if invite_confirm == true {
            id_member.removeValue(forKey: index)
            name_member.removeValue(forKey: index)
            img_member.removeValue(forKey: index)
         
            print("해제")
            
            invite_confirm = false // 다시 바꿔주기
        }
        
     
     
       
        
    } //btn_invite
    
  
       
        }


//cell 안에 있는 버튼 이벤트 처리 방법
//extension C_FollowTableViewCell: AddGroupProticol{
//
//    func btn_add_invite2(index: Int ,invite_id: String, invite_name: String,invite_img: String) {
//
//    }
//}
//
//extension C_FollowTableViewCell: AddGroupProticol2{
//
//    func btn_add_invite(test1: Int, test2: String, test3: String, test4: String) {
//
//    }
//
//}
