//
//  MypageViewController.swift
//  health
//
//  Created by Songjeongpyeong on 2021/10/13.
//

import UIKit
import MaterialComponents.MaterialBottomSheet
import Charts

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
   
    @IBOutlet weak var chart_view: BarChartView!
    
    
    
    var MypagelistItem: NSMutableArray = NSMutableArray()// 마이페이지 : DB에서 값 받아오는 곳
    var MypageFollowerCountItem: NSMutableArray = NSMutableArray()// 마이페이지 : DB에서 값 받아오는 곳
    var MypageFollowingCountItem: NSMutableArray = NSMutableArray()// 마이페이지 : DB에서 값 받아오는 곳
    var MypageMonthCountItem: NSMutableArray = NSMutableArray()// 마이페이지 : DB에서 값 받아오는 곳
    
    
    var months: [String]! // 차트 달
    var unitsSold: [Int]!
   var month_Db_coount: Int!
    
    var months_date_diction = [Int :  Int]()
    
    var months_date_array: [Int]! // 차트 달
    var months_count_array: [Int]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        months = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
        months_date_array = [1, 2, 3, 4, 5, 6 ,7 ,8 ,9 ,10 ,11 ,12]
        // Do any additional setup after loading the view.
     
        // 이미지 깍기
        img_profile.layer.cornerRadius = 13
        img_profile.clipsToBounds = true
        
//        middleButton.clipsToBounds = true
        img_profile.layer.cornerRadius = img_profile.frame.size.width / 2

        // 버튼 깍기
        btn_profile_my.layer.cornerRadius = 10 // 버튼 모서리 깍기
       
        //테두리 굵기
        btn_profile_my.layer.borderWidth = 2
              //테두리 색상
        btn_profile_my.layer.borderColor = CGColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        
       

        // 차트 데이터가 없을때
        chart_view.noDataText = "데이터가 없습니다."
        chart_view.noDataFont = .systemFont(ofSize: 20)
        chart_view.noDataTextColor = .lightGray
       
    } //viewDidLoad
    
    
    override func viewWillAppear(_ animated: Bool){
        self.title = "Mypage"
        
        if  months_date_diction.count != 0 {
            months_date_diction.removeAll()
        }
        
      
        
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
        
        //  팔로워 인원
        let my_montCountDB = MyMonth_count()
        my_montCountDB.delegate = self
        my_montCountDB.MyMonth_countdownItems(user_u_no: Share.user_no)
        
        
        
        
        
        // setChart(dataPoints: months, values: unitsSold)
        
    }//viewWillAppear
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "sG_profile_change" {
          
          let profileView  = segue.destination as! MypageProfileViewController
          
            let mypage_item: DBModel = MypagelistItem[0] as! DBModel
            
            profileView.id = "\(mypage_item.my_u_id!)"
            profileView.name = "\(mypage_item.my_u_name!)"
            profileView.intruduce = "\(mypage_item.my_u_introduce!)"
            profileView.img_name = "\(mypage_item.my_u_img!)"
        
         
        }
    }
   

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
    
    //                        차트 시작
    func chartStart()  {
        
        
        for i in 0...month_Db_coount-1 {
            
            let my_monnthcount_item: DBModel = MypageMonthCountItem[i] as! DBModel
         //  months_count_array.append(my_monnthcount_item.month_count!)
            months_date_diction.updateValue(my_monnthcount_item.month_count!, forKey: my_monnthcount_item.month!)
       
        } //for
        
      //  print("\(months_count_array!) ckstlr")
        print("\(months_date_diction) ckstlr1")
        
        
        for i in 1...12 {
            
            if months_date_diction[i] == nil {
                months_date_diction.updateValue(0, forKey: i)
            }
            
        } //for
        print("\(months_date_diction) ckstlr2")
        print("\(months_date_array!) ckstlr3")
        setChart(dataPoints: months, values: [1])
    }
    
    func setChart(dataPoints: [String], values: [Int]) {

        
        // 데이터 생성
        var dataEntries: [BarChartDataEntry] = []
       
        for i in months_date_array {
            
            let dataEntry = BarChartDataEntry(x: Double(i-1), y: Double(months_date_diction[i]!))
            
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "운동 횟수")

        // 차트 컬러
        chartDataSet.colors = [.systemBlue]

        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        chart_view.data = chartData
        // 선택 안되게
        chartDataSet.highlightEnabled = false
        // 줌 안되게
        chart_view.doubleTapToZoomEnabled = false
        
        
        // X축 레이블 위치 조정
        chart_view.xAxis.labelPosition = .bottom
        // X축 레이블 포맷 지정
        chart_view.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
      
        // X축 레이블 갯수 최대로 설정 (이 코드 안쓸 시 Jan Mar May 이런식으로 띄엄띄엄 조금만 나옴)
        chart_view.xAxis.setLabelCount(dataPoints.count, force: false)
        
        // 오른쪽 레이블 제거
        chart_view.rightAxis.enabled = false
        
        //기본 애니메이션
        chart_view.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        //옵션 애니메이션
       // chart_view.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
    }
    
    
    
    
    
    //                        차트 끝
    
    
   
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
        btn_folloing_my.text("팔로윙(\(my_folloingCoungt_item.following_coun!)명)")
    }
    
    
    
}



extension MypageViewController : My_followoerCountProtocol {
    func My_followoerCounttemDownloaded(items: NSMutableArray, g_list_cout: Int) {
        MypageFollowerCountItem = items
        let my_followoerCoungt_item: DBModel = MypageFollowerCountItem[0] as! DBModel
        btn_follower_my.text("팔로워(\(my_followoerCoungt_item.followoer_count!)명)")
    }
    
    
}


extension MypageViewController : MyMonth_countProtocol {
    func MyMonth_countitemDownloaded(items: NSMutableArray, g_list_cout: Int) {
      
        month_Db_coount = g_list_cout
        MypageMonthCountItem = items
        print(" 여기 달마다 운동한게 아예없군 \(g_list_cout)")
        guard g_list_cout != 0 else {
            print(" 여기 달마다 운동한게 아예없군s ")
            return
        }
        chartStart()
 
        //setChart(dataPoints: months, values: months_count_array!)
    }
    
    
}

