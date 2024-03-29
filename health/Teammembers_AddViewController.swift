//
//  Teammembers_AddViewController.swift
//  health
//
//  Created by Songjeongpyeong on 2021/09/05.
//

import UIKit
var sm_num = 0

class Teammembers_AddViewController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate {

   
    @IBOutlet weak var sm_follow: UISegmentedControl! //팔로우, 팔로잉 구분 세그먼트 기능
    @IBOutlet weak var g_tv_followlist: UITableView! // 테이블뷰
    @IBOutlet weak var g_searchBar: UISearchBar!
    
   
    var FollowlistItem: NSArray = NSArray()// DB에서 값 받아오는 곳
    var Follow_o: NSArray = NSArray()// DB에서 값 받아오는 곳
    var Follow_t: NSArray = NSArray()// DB에서 값 받아오는 곳
   
    
  
 
    var CF_cell = C_FollowTableViewCell()
    var ADD_controlle = AddGroupViewController()
    var followNum_o = 0
    var followNum_t = 0
  
  
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //                  서치바 관련 시작                          //
        g_searchBar.delegate = self
        g_searchBar.barStyle = .default //스타일
        g_searchBar.placeholder = "검색"
      
        sm_follow_o() //following_check_member    불러오는 값
        sm_follow_t()  //following_check_member    불러오는 값
     
        
        
    }//viewDidLoad
    
    override func viewWillAppear(_ animated: Bool){
        
        sm_funtio()
       
        
        makeSingleTouch() //세그 먼트 조절하기
        
        
        print("여기는 테이블븅의 viewWillAppear")
        // 테이블뷰 실제 실헹
        
        g_tv_followlist.delegate = self
        g_tv_followlist.dataSource = self
        
        
        sm_follow.selectedSegmentIndex = 0
        sm_num  = 0
        sm_funtio()
        
        self.g_tv_followlist.reloadData()
        
       
      
        
    }//viewWillAppear
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sm_funtio()
        self.g_tv_followlist.reloadData()
    }
    
   
    
    // MARK: 세그먼트 컨트롤러
    @IBAction func sm_follow(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
          
         
//
//            UIView.animate(withDuration: 0.2) { [self] in
//                CF_cell.btn_invite.tintColor = UIColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
//                                                                     }
                
            sm_num = 0
            sm_funtio()
            //self.g_tv_followlist.reloadData()
            
        }else if sender.selectedSegmentIndex == 1{
//            UIView.animate(withDuration: 0.2) { [self] in
//                CF_cell.btn_invite.tintColor = UIColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
//                                                                     }
       
            
            sm_num = 1
            
            sm_funtio()
            
            //self.g_tv_followlist.reloadData()
    }
        
        
    }
  
    
    
    
    
    
    // 뒤로가기 버튼
    @IBAction func back_btn(_ sender: UIButton) {
        
        // 팀원 리스트 값 모두 없애기
        id_member.removeAll()
        name_member.removeAll()
        img_member.removeAll()
        index_member.removeAll()
        
        self.presentingViewController?.dismiss(animated: true)
    }
    
    // MARK: 팀원 추가
    @IBAction func btn_memberAdd(_ sender: UIButton) {
      
        
        
        if id_member.count == 0 {
            member_AddAlert()
            
            
        }else if id_member.count > 0 {
          
            

            print("\(id_member) 팀")
            print("\(name_member) 팀")
            print("\(img_member) 팀")
            print("\(index_down) 팀")
       
            subway  = key + f_key
            
            subway2_down = removeDuplication(in: subway)
          
          
            
            for i in fr_u_no_list {
                    if final_u_nolist.contains(i) == false {
                        final_u_nolist.append(i)
                    }
                }
            for i in fg_u_no_list {
                    if final_u_nolist.contains(i) == false {
                        final_u_nolist.append(i)
                    }
                }
            
      
       
            print("\(final_u_nolist)하이용 최종")
           print("\(subway2_down) 집합")
           
            
            
      //      delegate2?.didMessageEditDone3(self, id_protocol: id_member, name_protocol: name_member, img_protocol: img_member)
            navigationController?.popViewController(animated: true) // 화면 보내는 친구
            sm_follow.selectedSegmentIndex = 0
            sm_num  = 0
            //  navigationController?.popViewController(animated: true) // 화면 보내는 친구
       
        
        
        }
      
    }
    
    // 중복 제거
    func removeDuplication(in array: [String]) -> [String]{
        let set = Set(array)
        let duplicationRemovedArray = Array(set)
        
      //  subway2 = duplicationRemovedArray.sorted(by: <)
        return duplicationRemovedArray
    }
    
    // 추가 완료 버튼 누를 시 사람 없을 경울 alert 띄우기
    
    
      func member_AddAlert() {
         
           let resultAlert = UIAlertController(title: "경고", message: "친구를 한명 이상 추가해주세요", preferredStyle: .alert)
           let onAction = UIAlertAction(title: "OK", style: .default, handler: { ACTION in
             //  self.navigationController?.popViewController(animated: true)
           })
           resultAlert.addAction(onAction)
           present(resultAlert, animated: true, completion: nil)
           
       
      }
      
    //following_check_member    불러오는 값
    func sm_follow_o()  {
     
        if following_check_member.count == 0{
        let gm_Follow_o = GM_follow_o()
            gm_Follow_o.delegate = self
            gm_Follow_o.GM_Follow_odownItems(user_u_no: Share.user_no, check: 0,searchTexts: "\(g_searchBar.text!)")
        
        }
        
       
    }
    //following_check_member    불러오는 값
    func sm_follow_t()  {
        if follower_check_member.count == 0{
        let gm_Follow_o = GM_Follow_t()
            gm_Follow_o.delegate = self
            gm_Follow_o.GM_Follow_tdownItems(user_u_no: Share.user_no, check: 1,searchTexts: "\(g_searchBar.text!)")
        
        }
    }
    
    // 세그먼트 DB기능 모아 놓기
    func sm_funtio()  {

        let gm_FollowlistDB = GM_FollowlistDB()
          gm_FollowlistDB.delegate = self
        

        if sm_num == 0 {
            
           // FollowlistItem.removeAllObjects()
         //   self.g_tv_followlist.reloadData()
            gm_FollowlistDB.GM_FollowlistDBdownItems(user_u_no: Share.user_no, check: 0,searchTexts: "\(g_searchBar.text!)")
           
            
      
        }else if sm_num == 1 {
            
         //   FollowlistItem.removeAllObjects()
          //  self.g_tv_followlist.reloadData()
            gm_FollowlistDB.GM_FollowlistDBdownItems(user_u_no: Share.user_no, check: 1,searchTexts: "\(g_searchBar.text!)")
            
        }
        
    }
    
    //MARK: 키보드 내리는 소스
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    //                         스와이프로 세그 먼트 조절하기               //
    
    func makeSingleTouch() {
        let swiperight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(_:)))
        swiperight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swiperight)
        
        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(_:)))
        swipeleft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeleft)
    
    
    }
    
    
    
    
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
            // 만일 제스쳐가 있다면
            if let swipeGesture = gesture as? UISwipeGestureRecognizer{
                
                // 발생한 이벤트가 각 방향의 스와이프 이벤트라면
                // pageControl이 가르키는 현재 페이지에 해당하는 이미지를 imageView에 할당
                switch swipeGesture.direction {
                    case UISwipeGestureRecognizer.Direction.left :
                        sm_follow.selectedSegmentIndex = 1
                        sm_num = 1
                        sm_funtio()
                        
                    case UISwipeGestureRecognizer.Direction.right :
                       
        
                          if  sm_follow.selectedSegmentIndex == 0 {
                            
                            
                            // 팔로우 리스트들 삭제
                            id_member.removeAll()
                            name_member.removeAll()
                            img_member.removeAll()
                            index_member.removeAll()
                            check_member.removeAll()
                            key.removeAll()
                            f_key.removeAll()
                         
                            
                            subway2_down.removeAll()
                            subway2.removeAll()
                            subway.removeAll()
                            following_check_member.removeAll()
                            follower_check_member.removeAll()
                            
                            
                            self.dismiss(animated: true, completion: nil) // 스와이프 뒤로가기
                            
                        }else if  sm_follow.selectedSegmentIndex == 1 {
                            sm_follow.selectedSegmentIndex = 0
                            sm_num = 0
                            sm_funtio()
                            
                            
                        }
                        
                       
                    default:
                      break
                }

            }

        }
    
    //                         스와이프로 세그 먼트 조절하기 끝               //
    
    
    
    
}//Teammembers_AddViewController



//                                         테이블뷰 시작                                                                     //

extension Teammembers_AddViewController: UITableViewDelegate, UITableViewDataSource{
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
    
        return FollowlistItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "g_followcell", for: indexPath) as! C_FollowTableViewCell
        
   
       
        let item: DBModel = FollowlistItem[indexPath.row] as! DBModel // 그룹 제목, 종료날짜 가져오기
        
        DispatchQueue.global().async {
            guard let url = URL(string: "\(Share.imgurl)\(item.u_img!)") else { return }
            print("\(url)")
            
            guard let data = try? Data(contentsOf: url) else {
                return
            }
            DispatchQueue.main.async {
                cell.imgview_profileimg.image = UIImage(data: data)
            }
        }
        print("여기는 테이블뷸 ")
        cell.lbl_idprofile.text? = "\(item.u_id!)"
        cell.lbl_nameprofile.text? = "\(item.u_name!)"
        cell.selectionStyle = .none
        index_num = indexPath.row

        
        cell.index = indexPath.row
        cell.invite_id = "\(item.u_id!)"
        cell.invite_name = "\(item.u_name!)"
        cell.invite_img = "\(item.u_img!)"
        cell.invite_uno = Int("\(item.u_no!)")
       

        
        //  print("성공 팔로워 \(sm_num), 아이디: \(item.u_name!) , 참거짓 \(String(describing: follower_check_member["\(item.u_id!)"]))")
        print("성공 팔로윙 \(sm_num), 아이디: \(item.u_name!) , 참 & 거짓 \(String(describing: follower_check_member["\(item.u_id!)"])), 인덱스 \(indexPath.row), 카운트 \(FollowlistItem.count)")
             
        if sm_follow.selectedSegmentIndex == 0 {
            
        print("성공 sm = 0")
            
       
        cell.btn_invite.tintColor = UIColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                                       
            
            
        if following_check_member["\(item.u_id!)"] == true ||  follower_check_member["\(item.u_id!)"] == true {
           
        print("성공")
            
      
            cell.btn_invite.tintColor = UIColor(#colorLiteral(red: 0.2483623028, green: 0.5312670469, blue: 0.9978526235, alpha: 1))
            
            
        
        }
        }// if 끝
       
        
        
        if sm_follow.selectedSegmentIndex == 1 {
            
            print("성공 sm = 1")
         
      
                cell.btn_invite.tintColor = UIColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                print("성공 sm = 1 색상")
        
            
            
            if  follower_check_member["\(item.u_id!)"] == true || following_check_member["\(item.u_id!)"] == true  {
                
                
               
                print("성공 튜")
          
                cell.btn_invite.tintColor = UIColor(#colorLiteral(red: 0.2483623028, green: 0.5312670469, blue: 0.9978526235, alpha: 1))
                                                                     
            }
            
        } //if 끝
        
      //  cell.btn_invite.tintColor = UIColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        
        return cell
    
    }// 테이블 뷰
    
    // 셀 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath2: IndexPath) {
                if let cell = tableView.cellForRow(at: indexPath2) {
                    let backgroundView = UIView()
                    backgroundView.backgroundColor = UIColor.white
                    cell.selectedBackgroundView = backgroundView
           }
        
    
}
}
//                                         테이블뷰 끝                                                                     //



extension Teammembers_AddViewController : GM_Follow_tProtocol {
  
    func GM_Follow_titemDownloaded(follow_t_items: NSArray, g_list_cout: Int) {
        
        Follow_t = follow_t_items as! NSMutableArray
        self.g_tv_followlist.reloadData()
        followNum_t = g_list_cout - 1
        
        
        if follower_check_member.count == 0 {


            for i in 0...followNum_t {
                print("\(followNum_t) 값이")
                let item: DBModel = Follow_t[i] as! DBModel // 그룹 제목, 종료날짜 가져오기

                follower_check_member.updateValue(false, forKey: item.u_id!)
                print("\(follower_check_member) 팔로워값이 돌아??")

            }
        } // if
        
    }
    
    
}


//GM_follow_o
extension Teammembers_AddViewController : GM_Follow_oProtocol {
    func GM_Follow_oitemDownloaded(follow_o_items: NSArray, g_list_cout: Int) {
        
        
        Follow_o = follow_o_items as! NSMutableArray
        self.g_tv_followlist.reloadData()
        followNum_o = g_list_cout - 1
        
        
        if following_check_member.count == 0  {
        
        for i in 0...followNum_o {
            print("\(followNum_o) 값이")
            
            let item: DBModel = Follow_o[i] as! DBModel // 그룹 제목, 종료날짜 가져오기
            following_check_member.updateValue(false, forKey: item.u_id!)
            print("\(check_member) 값이 돌아??")
        }
        } // if 끝
        
//        if follower_check_member.count == 0 {
//
//
//            for i in 0...followNum {
//                print("\(followNum) 값이")
//                let item: DBModel = Follow_o[i] as! DBModel // 그룹 제목, 종료날짜 가져오기
//
//                follower_check_member.updateValue(false, forKey: item.u_id!)
//                print("\(follower_check_member) 팔로워값이 돌아??")
//
//            }
//        } // if
        
        
        
    }
    
    
    
    
}

extension Teammembers_AddViewController : GM_FollowlistDBProtocol {
   

    func GM_FollowlistDBitemDownloaded(items: NSArray, g_list_cout: Int) {
        FollowlistItem = items as! NSMutableArray

        self.g_tv_followlist.reloadData()
        
    }
}


//cell 안에 있는 버튼 이벤트 처리 방법
extension Teammembers_AddViewController: C_FollowProductCellDelegate{
    func btn_invite(index: Int ,invite_id: String, invite_name: String,invite_img: String) {

    }
}

extension Teammembers_AddViewController: AddGroupProticol2{

    func btn_add_invite(test1: Int, test2: String, test3: String, test4: String) {

    }

}
