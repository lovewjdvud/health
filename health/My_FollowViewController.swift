//
//  My_FollowViewController.swift
//  health
//
//  Created by Songjeongpyeong on 2021/10/19.
//

import UIKit
import MaterialComponents.MaterialBottomSheet

class My_FollowViewController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sGment_my: UISegmentedControl!
    
    var My_FollowlistItem: NSArray = NSArray()// DB에서 값 받아오는 곳
    
    var sm_my_num = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //                  서치바 관련 시작                          //
        searchBar.delegate = self
        searchBar.barStyle = .default //스타일
        searchBar.placeholder = "검색"
        
        // Do any additional setup after loading the view.
    } //viewDidLoad
    
    
    
    override func viewWillAppear(_ animated: Bool){
    
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        sGment_my.selectedSegmentIndex = 0
        sm_num  = 0
        sm_funtio()
        self.tableView.reloadData()
        
    } //viewWillAppear
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sm_funtio()
        self.tableView.reloadData()
        
    }
    
    @IBAction func sgment(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
          
         
//
//            UIView.animate(withDuration: 0.2) { [self] in
//                CF_cell.btn_invite.tintColor = UIColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
//                                                                     }
                
            sm_num = 0
            sm_funtio()
            
            self.tableView.reloadData()
            
        }else if sender.selectedSegmentIndex == 1{
//            UIView.animate(withDuration: 0.2) { [self] in
//                CF_cell.btn_invite.tintColor = UIColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
//                                                                     }
       
            
            sm_num = 1
            
            sm_funtio()
            
            self.tableView.reloadData()
    }
        
    }
    
    
    // 세그먼트 DB기능 모아 놓기
    func sm_funtio()  {

        let my_FollowlistDB = GM_FollowlistDB()
        my_FollowlistDB.delegate = self
        

        if sm_num == 0 {
            
 
            my_FollowlistDB.GM_FollowlistDBdownItems(user_u_no: Share.user_no, check: 0,searchTexts: "\(searchBar.text!)")
           
            
      
        }else if sm_num == 1 {
            

            my_FollowlistDB.GM_FollowlistDBdownItems(user_u_no: Share.user_no, check: 1,searchTexts: "\(searchBar.text!)")
            
        }
        
    }
    

    
   
    
    
    

} //My_FollowViewController


//                                         테이블뷰 시작                                                                     //

extension My_FollowViewController: UITableViewDelegate, UITableViewDataSource{
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
    
        return My_FollowlistItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "My_followcell", for: indexPath) as! C_MyFollowTableViewCell
        
   
       
       let item: DBModel = My_FollowlistItem[indexPath.row] as! DBModel // 그룹 제목, 종료날짜 가져오기
        
        DispatchQueue.global().async {
            guard let url = URL(string: "\(Share.imgurl)\(item.u_img!)") else { return }
            print("\(url)")
            
            guard let data = try? Data(contentsOf: url) else {
                return
            }
            DispatchQueue.main.async {
                cell.img_my_follow.image = UIImage(data: data)
            }
        }
    
        cell.lbl_id_myCell.text? = "\(item.u_id!)"
        cell.lbl_name_myCell.text? = "\(item.u_name!)"
       

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


extension My_FollowViewController : GM_FollowlistDBProtocol {
   

    func GM_FollowlistDBitemDownloaded(items: NSArray, g_list_cout: Int) {
        My_FollowlistItem = items as! NSMutableArray

        self.tableView.reloadData()
        
    }
    
    
}
