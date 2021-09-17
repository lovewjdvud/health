//
//  C_FollowTableViewCell.swift
//  health
//
//  Created by Songjeongpyeong on 2021/09/06.
//

import UIKit
import Foundation

var check_member = [Int :  Bool]()
var test = [Int : String]()
var id_member = [Int :  String]()
var name_member = [Int : String]()
var img_member = [Int : String]()
var index_member: [Int] = []
var index_down: [Int] = []
var index_num = 0
//index_member.sorted(by: <)

var invite_confirm = false

protocol C_FollowProductCellDelegate {
    func btn_invite(index: Int ,invite_id: String, invite_name: String,invite_img: String)
}


class C_FollowTableViewCell: UITableViewCell {

  
    @IBOutlet weak var imgview_profileimg: UIImageView!
    @IBOutlet weak var lbl_idprofile: UILabel!
    @IBOutlet weak var lbl_nameprofile: UILabel!
    
    @IBOutlet weak var btn_invite: UIButton!
    var delegate2: EditDelegate?
    var delegate: C_FollowProductCellDelegate?
    var index2: Int = 0
    var index: Int!
 
    
    // 클릭시 받아 온값
    var invite_id = ""
    var invite_name = ""
    var invite_img = ""
  
    var test_C = B_GFollowlist()
    // 클릭시 넣을 값
    var invite_id_array: [String] = []
    var invite_name_array: [String] = []
    var invite_img_array: [String] = []
   
  

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        btn_invite.layer.cornerRadius = 10 // 버튼 모서리 깍기
        imgview_profileimg.layer.cornerRadius = 39.6
        imgview_profileimg.clipsToBounds = true
        
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
        self.delegate?.btn_invite(index: index, invite_id: invite_id, invite_name: invite_name, invite_img: invite_img)
      
//        UIView.animate(withDuration: 0.2) {
//            sender.tintColor = UIColor(#colorLiteral(red: 0.2483623028, green: 0.5312670469, blue: 0.9978526235, alpha: 1))
//               }
        
        //check_member[index] == false
        
        if check_member[index] == false {

            print("\(index!) 흠 \(invite_name)")
            id_member.updateValue("\(invite_id)", forKey: index)
            name_member.updateValue("\(invite_name)", forKey: index)
            img_member.updateValue("\(invite_img)", forKey: index)
            index_member.append(index)
            index_down = index_member.sorted(by: <)
            
         
            print("\(id_member) 셀 추가")
            print("\(name_member) 셀 추가")
            print("\(img_member) 셀 추가")
            print("\(index_down) 셀 추가")
            print("\(index_member) 셀 추가")
            print("\(invite_id) 여기는 추가")
         
            
            check_member.updateValue(true, forKey: index)
            
            print("여기는 \(check_member[index]!)  이거는 인덱스 넘\(index_num) 이거는 인덱스 \(index!)")
            invite_confirm = false // 다시 바꿔주기
            
            
            
        } else if  check_member[index] == true {
            id_member.removeValue(forKey: index)
            name_member.removeValue(forKey: index)
            img_member.removeValue(forKey: index)
          //index_member.firstIndex(of: 3)
            index_member.remove(at: index_member.firstIndex(of: index)!)
            index_down = index_member.sorted(by: <)
//          index_down.remove(at: index)
            print("해제")
            
            print("\(id_member) 셀 삭제")
            print("\(name_member) 셀 삭제")
            print("\(img_member) 셀 삭제")
            print("\(index_down) 인덱스 다윤 셀 삭제")
            print("\(index_member) 인덱스 멤버 셀 삭제")
            
            print("\(index!) 셀 삭제")
            check_member.updateValue(false, forKey: index)
            invite_confirm = true // 다시 바꿔주기
        }
        
     
     
       
        
    } //btn_invite
    
  
       
        }


//cell 안에 있는 버튼 이벤트 처리 방법
extension C_FollowTableViewCell: AddGroupProticol{

    func btn_add_invite2(index: Int ,invite_id: String, invite_name: String,invite_img: String) {

    }
}

extension C_FollowTableViewCell: AddGroupProticol2{

    func btn_add_invite(test1: Int, test2: String, test3: String, test4: String) {

    }

}
