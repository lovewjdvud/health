//
//  MypageViewController.swift
//  health
//
//  Created by Songjeongpyeong on 2021/10/13.
//

import UIKit
import MaterialComponents.MaterialBottomSheet
class MypageViewController: UIViewController {

    @IBOutlet weak var btn_folloing_my: UIButton!
    @IBOutlet weak var btn_follower_my: UIButton!

    @IBOutlet weak var lbl_following: UILabel!
    
    @IBOutlet weak var lbl_follower: UILabel!
    
    
    @IBOutlet weak var img_profile: UIImageView!
    
    @IBOutlet weak var lbl_id_my: UILabel!
    @IBOutlet weak var lbl_name_my: UILabel!
    @IBOutlet weak var lbl_introduce_my: UILabel!
    
    @IBOutlet weak var btn_profile_my: UIButton!
    
    
    var MypagelistItem: NSMutableArray = NSMutableArray()// 마이페이지 : DB에서 값 받아오는 곳
    var MypageFollowerCountItem: NSMutableArray = NSMutableArray()// 마이페이지 : DB에서 값 받아오는 곳
    var MypageFollowingCountItem: NSMutableArray = NSMutableArray()// 마이페이지 : DB에서 값 받아오는 곳
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
     
        // 이미지 깍기
        img_profile.layer.cornerRadius = 13
        img_profile.clipsToBounds = true
        
//        middleButton.clipsToBounds = true
        img_profile.layer.cornerRadius = img_profile.frame.size.width / 2

        // 버튼 깍기
        btn_profile_my.layer.cornerRadius = 10 // 버튼 모서리 깍기
       
        
       

        
       
        
    } //viewDidLoad
    
    
    override func viewWillAppear(_ animated: Bool){
        self.title = "Mypage"
        // 프로핗 디비
        let mypagelist_listDB = Mypagelist()
        mypagelist_listDB.delegate = self
        mypagelist_listDB.MypagelistlistdownItems(user_u_no: Share.user_no)
    
        //팔로윙 인원
        let my_followingNumDB = My_followingCount()
        my_followingNumDB.delegate = self
        my_followingNumDB.My_followingCountdownItems(user_u_no: Share.user_no)
   
        //  팔로워 인원
        let my_followoerNumDB = My_followoerCount()
        my_followoerNumDB.delegate = self
        my_followoerNumDB.My_followoerCountdownItems(user_u_no: Share.user_no)
        
        
    }//viewWillAppear
    
   

    func profileseting()  {
       
        let mypage_item: DBModel = MypagelistItem[0] as! DBModel
        
        lbl_id_my.text? = "\(mypage_item.my_u_id!)"
        lbl_name_my.text? = "\(mypage_item.my_u_name!)"
        lbl_introduce_my.text? = "\(mypage_item.my_u_introduce!)"
       
        
        
        DispatchQueue.global().async {
            guard let url = URL(string: "\(Share.imgurl)\(mypage_item.my_u_img!)") else { return }
            print("\(url)")

            guard let data = try? Data(contentsOf: url) else {
                return
            }
            DispatchQueue.main.async {
                self.img_profile.image = UIImage(data: data)
            }
            
     
        }// DispatchQueue
        
       
    } //profileseting
    
    
    @IBAction func btn_folloing(_ sender: UIButton) {
        bottom()
    }
    
    @IBAction func btn_follower(_ sender: UIButton) {
        bottom()
    }
    
    func bottom()  {
        
        // 바텀 시트로 쓰일 뷰컨트롤러 생성
               let vc = storyboard?.instantiateViewController(withIdentifier: "My_FollowViewController") as! My_FollowViewController
               
           
               // MDC 바텀 시트로 설정
               let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: vc)
               
        
        // 높이
               bottomSheet.mdc_bottomSheetPresentationController?.preferredSheetHeight = 1100
        
        
        // 뒤에 배경 컬러
                bottomSheet.scrimColor = UIColor(#colorLiteral(red: 0.2874339819, green: 0.5118607879, blue: 1, alpha: 1)).withAlphaComponent(0.5)
               
        // 보여주기
               present(bottomSheet, animated: true, completion: nil)
        
        
    }
   
} //MypageViewController





extension MypageViewController : MypagelistProtocol {
    func MypagelistitemDownloaded(items: NSMutableArray, g_list_cout: Int) {
        MypagelistItem = items
        profileseting() // 프로필 셋팅
        
    }
}

extension MypageViewController : My_followingCountProtocol {
  
    func My_followingCountitemDownloaded(items: NSMutableArray, g_list_cout: Int) {
        MypageFollowingCountItem = items
        let my_folloingCoungt_item: DBModel = MypageFollowingCountItem[0] as! DBModel
        btn_folloing_my.text("팔로윙(\(my_folloingCoungt_item.following_coun!))명")
    }
    
    
    
}



extension MypageViewController : My_followoerCountProtocol {
    func My_followoerCounttemDownloaded(items: NSMutableArray, g_list_cout: Int) {
        MypageFollowerCountItem = items
        let my_followoerCoungt_item: DBModel = MypageFollowerCountItem[0] as! DBModel
        btn_follower_my.text("팔로워(\(my_followoerCoungt_item.followoer_count!))명")
    }
    
    
}

