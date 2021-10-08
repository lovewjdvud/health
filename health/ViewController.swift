//
//  ViewController.swift
//  health
//
//  Created by 송정평 on 2021/08/30.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    var GrouplistItem: NSMutableArray = NSMutableArray()// DB에서 값 받아오는 곳
    var G_no_Item: NSMutableArray = NSMutableArray()
    var test_num = 0
    var g_count : Int = 0
    var currentdate = ""  // 현재 날짜
    var usernum = 3
   
    let Cellview = C_AddGroupTableViewCell()
    // 인원 받아오기, 등록 날짜  불러오기
    
    var g_group_no = "" // 인원 받아오기 위한 값
    var user_num = [""]
    
    @IBOutlet weak var tableView_GroupList: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         tableView_GroupList.delegate = self
         tableView_GroupList.dataSource = self // 테이블뷰 실제 실헹
        tableView_GroupList.rowHeight = 95
     
        tableView_GroupList.separatorStyle = .none
        tableView_GroupList.showsVerticalScrollIndicator = false
        
      //  test()
        

    }//viewDidLoad
    
    
    // 다른 화면 갔다가 왔을때 해주고 싶은 처리
    override func viewWillAppear(_ animated: Bool){
        
      
         
        test_num += 1
        // 팔로우 리스트들 삭제
        id_member.removeAll()
        name_member.removeAll()
        img_member.removeAll()
        index_member.removeAll()
        check_member.removeAll()
        key.removeAll()
        f_key.removeAll()
        u_no_member.removeAll()
     
        
        subway2_down.removeAll()
        subway2.removeAll()
        subway.removeAll()
        following_check_member.removeAll()
        follower_check_member.removeAll()
        print("사랑 시이작")
        
        print("사랑 1")
          // 1초 후 실행
            let grouplistDB = GrouplistDB()
            grouplistDB.delegate = self
            grouplistDB.GrouplistDBdownItems(user_u_no: Share.user_no) // 실행
        print("사랑 5")
        
        
        
//        //인원수 가져오기
//        print("사랑 6")
//                 let g_noDB = Group_gno_DB()
//                 g_noDB.delegate = self
//                 g_noDB.Group_gno_DBdownItems(user_u_no: Share.user_no) // 실행
        print("사랑 ")
           // self.tableView_GroupList.reloadData()
        
        
    }// viewWillAppear
    
    
    /// 클릭스 디테일 뷰 보내기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
          if segue.identifier == "sgdetailTeam" {
            
            
            
            let cell = sender as! C_AddGroupTableViewCell
            let indexPath = self.tableView_GroupList.indexPath(for: cell)
        
            let detailView  = segue.destination as! Detail_ViewController
            let item: DBModel = GrouplistItem[indexPath!.row] as! DBModel // 그룹 제목, 종료날짜 가져오기
            
            let finishdate  = Date_Calculate(finishdate: item.g_finishday!, check: 0) // 종료일 계산해서 보내기

            
            
            
            detailView.finshdate = ("\(finishdate)")
            detailView.De_g_no = item.g_no!
            detailView.teamNum = item.count!
    }
        
        
        
    }

    // 날짜 계산
    func Date_Calculate(finishdate : String, check: Int) -> Int {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        currentdate = "\(dateFormatter.string(from: date))"
        print(dateFormatter.string(from: date))
       

        let endDate = dateFormatter.date(from:"\(finishdate)")!
        let startDate = dateFormatter.date(from:"\(currentdate)")!// 이친구가 앞
      //  print("\(finishdate) 안녕 데이트안에")
      //  print("\(currentdate) 안녕 데이트안에")
        var interval = startDate.timeIntervalSince(endDate)
        var days = Int(interval / 86400)
        
        
        if check == 0 {
            
            interval = endDate.timeIntervalSince(startDate)
            days = Int(interval / 86400)
            
        }
     
        
        return days
    }
    
}//ViewController


// Grouplistg 테이블의 값들 추출
extension ViewController : GrouplistDBProtocol {
   

    func itemDownloaded(items: NSMutableArray, g_list_cout: Int) {
     
        
      
      
        GrouplistItem = items
        g_count = g_list_cout
        
        print("\(GrouplistItem.count) 정평 글룹리스트")
        
        self.tableView_GroupList.reloadData()
        print("사랑 9")
            
        
        
        
    
        }
    }


//
//extension ViewController : Group_gno_DBProtocol {
//
//    func G_noitemDownloaded(items: NSMutableArray) {
//
//
//        G_no_Item = items
//        print("\(G_no_Item.count) 정평 그룹 인원수")
//     
//     // self.tableView_GroupList.reloadData()
//        print("사랑 10")
//
//
//    }
//}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    
    
//                  테이블뷰                                    //
    
    func numberOfSections(in tableView: UITableView) -> Int {
// #warning Incomplete implementation, return the number of sections
    return 1
    }
// 몇개의 셀을 구현할지 정하는 것
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return GrouplistItem.count 
    }

// 실제 셀의 값으 넣는곳
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! C_AddGroupTableViewCell

        cell.content_view.layer.cornerRadius = cell.content_view.frame.height / 2
//
//        DispatchQueue.global().async { [self] in
     
        let item: DBModel = GrouplistItem[indexPath.row] as! DBModel // 그룹 제목, 종료날짜 가져오기
       // let item2: DBModel = G_no_Item[indexPath.row] as! DBModel // 그룹 제목, 종료날짜 가져오기
       
        let cal_result = Date_Calculate(finishdate: "\(item.m_registerday!)", check: 1) // 날짜 넣기
        print("\(item.g_title!) 안녕")
        
      
        
       
        cell.lbl_group_title.text? = "\(item.g_title!)" // 팀이름
        cell.lbl_group_finshday.text? = "\(item.g_finishday!)" // 팀 종료 날짜
        cell.lbl_group_lastDay.text? = "\(cal_result)일차" // 지난날들
        
        cell.lbl_group_number.text? = "\(item.count!)명"
        return cell //리턴으로 셀의 값을 넣어 보낸다
} //tableView

    
}







