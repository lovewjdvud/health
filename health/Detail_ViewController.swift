//
//  Detail_ViewController.swift
//  health
//
//  Created by Songjeongpyeong on 2021/10/04.
//

import UIKit
import MaterialComponents.MaterialBottomSheet




class Detail_ViewController: UIViewController {

    

    @IBOutlet weak var item_uploadnext: UIBarButtonItem!
    
    @IBOutlet weak var tableView_CD: UITableView!
    var currentdate_detail = "" //
    var De_g_no: Int!    // 그룹 넘버
    var finshdate  = "" // 남은 종료일
    var teamNum: Int!    // 팀원수
    var DetaillistItem: NSMutableArray = NSMutableArray()// 디테일 : DB에서 값 받아오는 곳
    var Detailsub_listItem: NSMutableArray = NSMutableArray()// 디테일 서브 : DB에서 값 받아오는 곳
    
    var valuDetailsub_DB_counte: Int!
    var Detail_DB_count: Int!
    var detailsubarray_name: [String] = []
    var detail_name: [String] = []
    var detail_arr2: [String] = []
    var detailsub_name = [String :  String]()
  
    var final_name: [String] = []
    
    var value = ""
    var test1 =  [0 : "정평", 2 : "정평"]
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("정피영 \(De_g_no!)")
        print("정피영 \(teamNum!)명ㅌㄴ")
        // Cell의 크기 지정
        tableView_CD.rowHeight = 477 // 테이블뷰 크기 지정
        
        tableView_CD.delegate = self
        tableView_CD.dataSource = self // 테이블뷰 실제 실헹
        
        
        
       
        self.title = "프로젝트 완료까지 \(finshdate)일 남았습니다"
     
        
    }  //viewDidLoad
    
    
    
    
    override func viewWillAppear(_ animated: Bool){

        self.tableView_CD.reloadData()
        // 리셋
//        detail_name.removeAll()
//        detailsub_name.removeAll()
        
        // 현재 날짜 보내기 위함
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        currentdate_detail = "\(dateFormatter.string(from: date))"
        
        
        
        // 업로드 누락자 구하기 위한 디비
        let detailsub_listDB = Detailsub_DB()
        detailsub_listDB.delegate = self
        detailsub_listDB.DetailsublistdownItems(user_u_no: Share.user_no, g_no: De_g_no)
        
        
        // 디비 보내기
        let detaillistDB = Detail_DB()
        detaillistDB.delegate = self
        detaillistDB.Detail_DBlistdownItems(user_u_no: Share.user_no, g_no: De_g_no, currentdate: currentdate_detail)
        print("사랑 나옴")
        
        
        
       
        
    }
    
    

    
    func test()  {
        
                
                detail_arr2 = detailsubarray_name.filter{!detail_name.contains($0)}
            
            
            print("\(detail_arr2) 끝아니야?")

        

    }
//
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
          if segue.identifier == "sgUpload" {
            
            let uploadView  = segue.destination as! UploadViewController
            
            
            uploadView.currentDate = "\(currentdate_detail)"
            uploadView.up_g_no = De_g_no
      
          
          }
        
        
        
    }
    
    
    
    

} //Detail_ViewController






extension Detail_ViewController: UITableViewDelegate, UITableViewDataSource{
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
    
        switch section {
        
        case 0:
            return DetaillistItem.count
        case 1:
            return Detailsub_listItem.count - DetaillistItem.count
        default:
            return 0
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section < 1 {
            
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyCell", for: indexPath) as! C_DailyTableViewCell
        
        let item3: DBModel = DetaillistItem[indexPath.row] as! DBModel
        print("\(Detail_DB_count!) DB 사랑 테이블")
        print("\(teamNum!) 팀 인원 숫다사랑 테이블")
            print("\(item3.d_u_id!) 서리")
            
          
            print("\(detailsub_name) 서리")
            
            
            cell.lbl_id_CD.text? = "\(item3.d_u_id!)"
            cell.lbl_date_CD.text? = "\(item3.p_uploadday!)"
            cell.lbl_write_CD.text? = "\(item3.up_contains!)"
            cell.lbl_likecount_CD.text? = "좋아요 \(item3.up_like_count!)개"

            print("송정평평")
        DispatchQueue.global().async {
            guard let url = URL(string: "\(Share.imgurl)\(item3.up_img!)") else { return }
            print("\(url)")

            guard let data = try? Data(contentsOf: url) else {
                return
            }

            DispatchQueue.main.async {
                cell.img_upload_CD.image = UIImage(data: data)
            }
        }
//                cell.selectionStyle = .none
//
        
        DispatchQueue.global().async {
            guard let url = URL(string: "\(Share.imgurl)\(item3.d_u_img!)") else { return }
            print("\(url)")

            guard let data = try? Data(contentsOf: url) else {
                return
            }

            DispatchQueue.main.async {
                cell.img_id_CD.image = UIImage(data: data)
            }
        }
        
       
            return cell
        }else {
          
            test() // 등록 되지 않는 사용자들을 걸러 내기 위힘
            
            print("송정평평2")
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "Detailsubcell", for: indexPath) as! C_DetailsubTableViewCell
          
            let item4: DBModel = Detailsub_listItem[indexPath.row] as! DBModel
           
            print("송정평평2 \(item4.detailsub_u_id!)")
            print("송정평평2 \(detailsub_name)")
            print("송정평평2 \(final_name)")
            
            if Detail_DB_count == 0 {
                
            
            
            cell.lbl_detailsub.text? = "\(String(describing: detailsub_name[item4.detailsub_u_id!]!))님은 아직 업로드 하시지 않았습니다!"
            }else {
                cell.lbl_detailsub.text? = "\(detail_arr2[indexPath.row])님은 아직 업로드 하시지 않았습니다!"
            }

            
            return cell
        }
    
    }// 테이블 뷰

    
    
    }



// 디테일 테이블의 값들 추출
extension Detail_ViewController : Detail_DBProtocol {
   

    func detailitemDownloaded(items: NSMutableArray, g_list_cout: Int) {
        DetaillistItem = items
        
        
        
        print("\(g_list_cout) 사랑 디테일 카운트")
        Detail_DB_count = g_list_cout
        
        
        // 등록 되지 않는 사용자들을 걸러 내기 위힘
        if Detail_DB_count > 0 {
        for i in 0...g_list_cout-1 {
            let detailitem: DBModel = DetaillistItem[i] as! DBModel
           
            detail_name.append("\(detailitem.d_u_name!)")
            if(detailitem.d_u_no! == Share.user_no) {
                item_uploadnext.isEnabled = false
            }else {

            }
        }
        }
        print("\(detail_name) 이건")
        
      
      
        Detail_DB_count = g_list_cout
       
        
        
        
        self.tableView_CD.reloadData()
        
        
        
        
    
        }
    }


// 디테일 서브 테이블의 값들 추출
extension Detail_ViewController : Detailsub_DBProtocol {
   

    func detailsub_itemDownloaded(items: NSMutableArray, g_list_cout: Int) {
        valuDetailsub_DB_counte  = g_list_cout
        print("\(valuDetailsub_DB_counte!) 사랑 디테일 서브 카운트")
      
        Detailsub_listItem = items
        
        // 등록 되지 않는 사용자들을 걸러 내기 위힘
        if valuDetailsub_DB_counte > 0 {
        for i in 0...g_list_cout-1 {
            let detailsub_item: DBModel = Detailsub_listItem[i] as! DBModel
           
            detailsub_name.updateValue(detailsub_item.detailsub_u_nanme!,forKey: "\(detailsub_item.detailsub_u_id!)")
            detailsubarray_name.append(detailsub_item.detailsub_u_nanme!)
          
         
        }
        }
        print("\(detailsub_name) 이건 서브")
        
        // 당일날 업로드를 했을 시 업도드 버튼을 숨긴다
        
        
        
     
        self.tableView_CD.reloadData()
            
        
        
        
    
        }
    }
