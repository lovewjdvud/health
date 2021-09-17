//
//  Teammembers_AddViewController.swift
//  health
//
//  Created by Songjeongpyeong on 2021/09/05.
//

import UIKit

class Teammembers_AddViewController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate {

   
    @IBOutlet weak var sm_follow: UISegmentedControl! //팔로우, 팔로잉 구분 세그먼트 기능
    @IBOutlet weak var g_tv_followlist: UITableView! // 테이블뷰
    @IBOutlet weak var g_searchBar: UISearchBar!
    
   
    var FollowlistItem: NSArray = NSArray()// DB에서 값 받아오는 곳
   
    
  
 
    var CF_cell = C_FollowTableViewCell()
    var ADD_controlle = AddGroupViewController()
    var followNum = 0
    var sm_num = 0
  
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //                  서치바 관련 시작                          //
        g_searchBar.delegate = self
        g_searchBar.barStyle = .default //스타일
        g_searchBar.placeholder = "검색"
      
     
        
        
    }//viewDidLoad
    
    override func viewWillAppear(_ animated: Bool){
        sm_funtio()
       
        makeSingleTouch() //세그 먼트 조절하기
      
        print("여기는 테이블븅의 viewWillAppear")
        // 테이블뷰 실제 실헹
        g_tv_followlist.delegate = self
        g_tv_followlist.dataSource = self
        
      
        
       
      
        
    }//viewWillAppear
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sm_funtio()
        self.g_tv_followlist.reloadData()
    }
    
   
    
    // MARK: 세그먼트 컨트롤러
    @IBAction func sm_follow(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{

            sm_num = 0
            sm_funtio()
            
        }else if sender.selectedSegmentIndex == 1{
          
            sm_num = 1
            sm_funtio()
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
         
            ADD_controlle.add_id = id_member
            ADD_controlle.add_name = id_member
            ADD_controlle.add_img = id_member
            
            
      //      delegate2?.didMessageEditDone3(self, id_protocol: id_member, name_protocol: name_member, img_protocol: img_member)
            navigationController?.popViewController(animated: true) // 화면 보내는 친구
          
            //  navigationController?.popViewController(animated: true) // 화면 보내는 친구
       
        
        
        }
      
    }
    
    // 추가 완료 버튼 누를 시 사람 없을 경울 alert 띄우기
    
      //MARK: 버린날짜, 사용완료 Alert 중복
      func member_AddAlert() {
         
           let resultAlert = UIAlertController(title: "경고", message: "친구를 한명 이상 추가해주세요", preferredStyle: .alert)
           let onAction = UIAlertAction(title: "OK", style: .default, handler: { ACTION in
             //  self.navigationController?.popViewController(animated: true)
           })
           resultAlert.addAction(onAction)
           present(resultAlert, animated: true, completion: nil)
           
       
      }
      
    
    // 세그먼트 DB기능 모아 놓기
    func sm_funtio()  {

        let gm_FollowlistDB = GM_FollowlistDB()
          gm_FollowlistDB.delegate = self
        

        if sm_num == 0 {
            
           // FollowlistItem.removeAllObjects()
            self.g_tv_followlist.reloadData()
            gm_FollowlistDB.GM_FollowlistDBdownItems(user_u_no: Share.user_no, check: 0,searchTexts: "\(g_searchBar.text!)")
           
            
      
        }else if sm_num == 1 {
            
         //   FollowlistItem.removeAllObjects()
            self.g_tv_followlist.reloadData()
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
        
       // cell.imgview_profileimg
     //   cell.lbl_idprofile.text? = "wjdvud" // 아이디
     //   cell.lbl_nameprofile.text? = "송정평" // 이름
       
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
        print("여기는 테이블 인덱스 넘 \(index_num)")
        
        if check_member[indexPath.row] == true {
            
        
        UIView.animate(withDuration: 0.2) {
            cell.btn_invite.tintColor = UIColor(#colorLiteral(red: 0.2483623028, green: 0.5312670469, blue: 0.9978526235, alpha: 1))
                                                                 }
            
         //   invite_confirm = true // 다시 바꿔주기
        }
        
        cell.index = indexPath.row
        cell.invite_id = "\(item.u_id!)"
        cell.invite_name = "\(item.u_name!)"
        cell.invite_img = "\(item.u_img!)"
       

        
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



extension Teammembers_AddViewController : GM_FollowlistDBProtocol {
   

    func GM_FollowlistDBitemDownloaded(items: NSArray, g_list_cout: Int) {
        FollowlistItem = items as! NSMutableArray
        
        self.g_tv_followlist.reloadData()
        followNum = g_list_cout
        
        
        
        
        //  초기 값에 팔로우 false 값 넣어 주기
        if check_member.count == 0 {
        
        for i in 0...FollowlistItem.count {
            check_member.updateValue(false, forKey: i)
            print("\(check_member) 값이 돌아??")
        }
     
        } // if
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
