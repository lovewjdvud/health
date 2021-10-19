//
//  CalendarViewController.swift
//  health
//
//  Created by Songjeongpyeong on 2021/10/13.
//

import UIKit
import FSCalendar
import MaterialComponents.MaterialBottomSheet

class CalendarViewController: UIViewController {

   
    @IBOutlet weak var lbl_weight: UILabel!
    @IBOutlet weak var lbl_muscle: UILabel!
    @IBOutlet weak var lbl_fat: UILabel!
    @IBOutlet weak var textView_write: UITextView!
    @IBOutlet weak var img_claendar: UIImageView!
    @IBOutlet weak var btn_recoard: UIButton!
    @IBOutlet weak var btn_bottomsheet: UIButton!
    

    @IBOutlet weak var Calender: FSCalendar!
    
    let dateFormatter = DateFormatter()
    var cal_count : Int!
    var seletday_cal: String!
    var callistItem: NSMutableArray = NSMutableArray()// DB에서 값 받아오는 곳
    
    var cal_date: [String] = []
    var currentdate_cal: String!
///    var calendar_w: FSCalendar()
    
    var limit_current: String!
    var dates_2: Date!
    
    var dates: [Date] = []
    var events: [Date] = []
    var fillDefaultColorsDictionary = [String : Int ]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CalendarReplace()
        Calender.appearance.eventDefaultColor = UIColor.green
        Calender.appearance.eventSelectionColor = UIColor.green
    
        // 현재 날짜 보내기 위함

   
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        Calender.delegate = self
        Calender.dataSource = self
        
        
        // 운동기록 가져오기
        let calendar_listDB = CAL_calendarDB()
        calendar_listDB.delegate = self
        calendar_listDB.CAL_calendarDBistdownItems(user_u_no: Share.user_no)
        print("동현 cal")
        btn_bottomsheet.layer.cornerRadius = 30 // 버튼 모서리 깍기
    } //viewDidLoad
    
    override func viewWillAppear(_ animated: Bool){
        
        
        // 마크 컬러
        Calender.appearance.eventDefaultColor = UIColor.green
                
        
        // 운동기록 가져오기
        let calendar_listDB = CAL_calendarDB()
        calendar_listDB.delegate = self
        calendar_listDB.CAL_calendarDBistdownItems(user_u_no: Share.user_no)
    
      //  let item: DBModel = GrouplistItem[indexPath.row] as! DBModel // 그룹 제목, 종료날짜 가져오기
        btn_recoard.isHidden = true
       
        let date = Date()
        let dateFormatter_cal = DateFormatter()
        dateFormatter_cal.dateFormat = "yyyy-MM-dd"
        dateFormatter_cal.timeZone = TimeZone.current
       
         currentdate_cal = (dateFormatter_cal.string(from: date))
        
      //  dates_2 = dateFormatter_cal.date(from: <#T##String#>)
        
        cal_date.removeAll()
      
    }

 
    @IBAction func btn_comparison(_ sender: UIButton) {
        
        // 바텀 시트로 쓰일 뷰컨트롤러 생성
               let vc = storyboard?.instantiateViewController(withIdentifier: "Cal_BottomViewController") as! Cal_BottomViewController
               
        
        if seletday_cal == nil {
            seletday_cal = currentdate_cal
        }
        
        
                vc.select_date_FSCalendar =  seletday_cal!
                vc.cal_date_array = cal_date
               // MDC 바텀 시트로 설정
               let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: vc)
               
        
        // 높이
               bottomSheet.mdc_bottomSheetPresentationController?.preferredSheetHeight = 200
        
        
        // 뒤에 배경 컬러
                bottomSheet.scrimColor = UIColor(#colorLiteral(red: 0.2874339819, green: 0.5118607879, blue: 1, alpha: 1)).withAlphaComponent(0.5)
               
        // 보여주기
               present(bottomSheet, animated: true, completion: nil)
        
        
        
    }
    
    
    
    func CalendarReplace()  {
//         //달력의 평일 날짜 색깔
//        Calender.appearance.titleDefaultColor = .black
//
//        // 달력의 토,일 날짜 색깔
//        Calender.appearance.titleWeekendColor = .red
//
//        // 달력의 맨 위의 년도, 월의 색깔
//        Calender.appearance.headerTitleColor = .systemPink
//
//        // 달력의 요일 글자 색깔
//        Calender.appearance.weekdayTextColor = .orange
//
//
        
        
        // 달력의 년월 글자 바꾸기
        Calender.appearance.headerDateFormat = "YYYY년 M월"
        
        // 달력의 요일 글자 바꾸는 방법 1
        Calender.locale = Locale(identifier: "ko_KR")
        
        // 달력의 요일 글자 바꾸는 방법 2
        Calender.calendarWeekdayView.weekdayLabels[0].text = "일"
        Calender.calendarWeekdayView.weekdayLabels[1].text = "월"
        Calender.calendarWeekdayView.weekdayLabels[2].text = "화"
        Calender.calendarWeekdayView.weekdayLabels[3].text = "수"
        Calender.calendarWeekdayView.weekdayLabels[4].text = "목"
        Calender.calendarWeekdayView.weekdayLabels[5].text = "금"
        Calender.calendarWeekdayView.weekdayLabels[6].text = "토"

        // 배경색
        Calender.backgroundColor = UIColor(red: 241/255, green: 249/255, blue: 255/255, alpha: 1)
        
        //  선택 날짜
        Calender.appearance.selectionColor = UIColor(red: 38/255, green: 153/255, blue: 251/255, alpha: 1)
        
      
      
        // 스와이프 스크롤 작동 여부 ( 활성화하면 좌측 우측 상단에 다음달 살짝 보임, 비활성화하면 사라짐 )
        Calender.scrollEnabled = true
        // 스와이프 스크롤 방향 ( 버티칼로 스와이프 설정하면 좌측 우측 상단 다음달 표시 없어짐, 호리젠탈은 보임 )
        Calender.scrollDirection = .vertical
        
        // 년월에 흐릿하게 보이는 애들 없애기
        Calender.appearance.headerMinimumDissolvedAlpha = 0
        
        // 타이틀 컬러
        Calender.appearance.titleSelectionColor = .black
        // 서브 타이틀 컬러
        Calender.appearance.subtitleSelectionColor = .black
        
//        // 스와 이프로 여러개
//        Calender.swipeToChooseGesture.isEnabled = true
//        /// 여러개 선태ㅑㄱ
//        Calender.allowsMultipleSelection = true

       
    }
    
    // 날짜 계산
    func Date_Calculate(select : String)  {
       
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        limit_current = "\(dateFormatter.string(from: date))"
       
        print(dateFormatter.string(from: date))
       

        let select_date = dateFormatter.date(from:"\(select)")!
        
        let startDate = dateFormatter.date(from:"\(limit_current!)")!// 이친구가 앞
        
        
        if startDate < select_date {
            
    
            lbl_muscle.text? = ""
            lbl_fat.text? = ""
            lbl_weight.text? = ""
            textView_write.text? = ""
    
            lbl_fat.isHidden = true
            lbl_muscle.isHidden = true
            textView_write.isHidden = true
            lbl_weight.isHidden = true
            btn_bottomsheet.isHidden = true
    
            self.img_claendar.image = nil
            self.btn_recoard.isHidden = true
            
    
        }
        
   
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "Cel_recoard" {
          
          let detailView  = segue.destination as! Cal_recoardViewController
          
            detailView.selectday_recoed2 = seletday_cal
        
         
        } 
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

         self.view.endEditing(true)

   }
} //CalendarViewController


//}
//
//extension CalendarViewController: FSCalendarDataSource{
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        if self.dates.contains(date){
//            return 1
//        }
//        return 0
//    }
//}


extension CalendarViewController : FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    // ... 이 안에서 작성 시작할게요.
    
    // 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 선택됨")
        seletday_cal = dateFormatter.string(from: date)
        
        
        guard cal_count != 0 else {
            print("g_list_cout 카운트가 0이야")
            return
            
            
        }
        
        
//
//        lbl_muscle.text? = ""
//        lbl_fat.text? = ""
//        lbl_weight.text? = ""
//        textView_write.text? = ""
//
//        lbl_fat.isHidden = true
//        lbl_muscle.isHidden = true
//        textView_write.isHidden = true
//        lbl_weight.isHidden = true
//
//        self.img_claendar.image = nil
//        self.btn_recoard.isHidden = false
//
        
        
        for i in 0...cal_count-1 {
        let calitem: DBModel = callistItem[i] as! DBModel // 그룹 제목, 종료날짜 가져오기
            if calitem.r_uploadDay! ==  dateFormatter.string(from: date) {
                self.btn_recoard.isHidden = true
                lbl_fat.isHidden = false
                lbl_muscle.isHidden = false
                textView_write.isHidden = false
                lbl_weight.isHidden = false
                btn_bottomsheet.isHidden = false
           
                
                lbl_muscle.text? = "골격근 : \(calitem.e_muscle!)"
                lbl_fat.text? = "체지방 : \(calitem.e_fat!)"
                lbl_weight.text? = "몸무게 : \(calitem.e_weight!)"
                textView_write.text? = "\(calitem.e_write!)" //img_claendar
                
                
                DispatchQueue.global().async {
                    guard let url = URL(string: "\(Share.imgurl)\(calitem.e_img!)") else { return }
                    print("\(url)")

                    guard let data = try? Data(contentsOf: url) else {
                        return
                    } //DispatchQueue

                    DispatchQueue.main.async {
                        self.img_claendar.image = UIImage(data: data)
                    } //DispatchQueue
                    
                  
                }
                
               
                
            } //if
            
        } // for
        
        
        
        if currentdate_cal == dateFormatter.string(from: date) {
        
            btn_recoard.text("오늘 운동 기록하러 가기!")
            
        }else {
            btn_recoard.text("운동기록을 깜빡하셨나요?")
        }

        Date_Calculate(select: seletday_cal)
    }
    
    
    // 날짜 선택 해제 시 콜백 메소드
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 해제됨")
        
        lbl_muscle.text? = ""
        lbl_fat.text? = ""
        lbl_weight.text? = ""
        textView_write.text? = ""

        lbl_fat.isHidden = true
        lbl_muscle.isHidden = true
        textView_write.isHidden = true
        lbl_weight.isHidden = true
        btn_bottomsheet.isHidden = true
        self.img_claendar.image = nil
        self.btn_recoard.isHidden = false

        
        
       
        
        
    }
    
    
//    // 날짜 밑에 넣기
//    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//
//
//            switch dateFormatter.string(from: date) {
//
//            case dateFormatter.string(from: Date()):
//
//
//                return "오늘"
//
//            case "2021-10-22":
//
//                return "."
//            case "2021-10-23":
//                return "."
//            case "2021-11-24":
//                return "결근"
//            default:
//                return nil
//            }
//
//
//    }
//    // 날짜 밑에 넣기
//
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//
//
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "ko_KR")
//        formatter.dateFormat = "yyyy-MM-dd"
//
//
//
//        for i in 0...cal_count-1 {
//        let calitem: DBModel = callistItem[i] as! DBModel // 그룹 제목, 종료날짜 가져오기
//            let xmas = formatter.date(from: "\(calitem.r_uploadDay!)")
//       // let sampledate = formatter.date(from: "2021-10-2")
//
//
//        dates = [xmas!]
//
//
//
//        if self.dates.contains(date){
//                return 1
//            }
//        }
//
//
//
//            return 0
//        }
//
//
    
    
    
    
    //기본색상
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        //print("언제실행되는가?")
        let key = self.dateFormatter.string(from: date)
   
        
        if fillDefaultColorsDictionary[key] != nil{
            return (#colorLiteral(red: 0.7231525779, green: 0.9139678478, blue: 1, alpha: 1))
        }
 
        switch key {
        case currentdate_cal:
            return  UIColor.red
        default:
            return  UIColor.clear
        
    }
    
    }
//    // 날짜 자체를 바꾸기
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//
//
//        switch dateFormatter.string(from: date) {
//
//            case "2021-10-25":
//                return "D-day"
//            default:
//                return nil
//            }
//        }
//
//
    
//    // 날짜로 색 바꾸기
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
//          //  print("\(dateFormatter.string(from: date)) 이거는 카렌더 ")
//            switch dateFormatter.string(from: date) {
//            case "2021-10-22":
//                return .green
//            case "2021-10-23":
//                return .yellow
//            case "2021-10-24":
//                return .red
//            default:
//                return appearance.selectionColor
//            }
//        }

    // 최대 세개까지만 가능
//    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
//            // 날짜 3개까지만 선택되도록
//            if calendar.selectedDates.count > 3 {
//                return false
//            } else {
//                return true
//            }
//        }
    
//    // 선택 해제 불가
//    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
//            return false // 선택해제 불가능
//            //return true // 선택해제 가능
//        }
    
} // 카렌더 익스텐션


//GM_follow_o


extension CalendarViewController : CAL_calendarDBProtocol {
    func calitemDownloaded(items: NSMutableArray, g_list_cout: Int) {
        
        callistItem = items
        cal_count = g_list_cout
        
        guard cal_count != 0 else {
            print("g_list_cout 카운트가 0이야")
            return }
        
        
        
                      lbl_fat.isHidden = true
                       lbl_muscle.isHidden = true
                       textView_write.isHidden = true
                       lbl_weight.isHidden = true
                        btn_bottomsheet.isHidden = true
                       self.img_claendar.image = nil
                       self.btn_recoard.isHidden = false
        
       
            for i in 0...cal_count-1 {
            let calitem: DBModel = callistItem[i] as! DBModel // 그룹 제목, 종료날짜 가져오기
             
                cal_date.append("\(calitem.r_uploadDay!)")
                
                
                fillDefaultColorsDictionary.updateValue(i, forKey: "\(calitem.r_uploadDay!)")
                if calitem.r_uploadDay! ==  currentdate_cal{
                
                    lbl_fat.isHidden = false
                    lbl_muscle.isHidden = false
                    textView_write.isHidden = false
                    lbl_weight.isHidden = false
                    btn_bottomsheet.isHidden = false
                    self.btn_recoard.isHidden = true
                    
                    
                    lbl_muscle.text? = "골격근 : \(calitem.e_muscle!)"
                    lbl_fat.text? = "체지방 : \(calitem.e_fat!)"
                    lbl_weight.text? = "몸무게 : \(calitem.e_weight!)"
                    textView_write.text? = "\(calitem.e_write!)" //img_claendar
                    
                    
                    DispatchQueue.global().async {
                        guard let url = URL(string: "\(Share.imgurl)\(calitem.e_img!)") else { return }
                        print("\(url)")

                        guard let data = try? Data(contentsOf: url) else {
                            return
                        } //DispatchQueue

                        DispatchQueue.main.async {
                            self.img_claendar.image = UIImage(data: data)
                        } //DispatchQueue
                        
                      
                    } //DispatchQueue
                    
                }
//                } else if calitem.r_uploadDay! !=  currentdate_cal{
//
//
//
//                } //if
                    
                } //for
  
        
        Calender.reloadData()
        
    } //calitemDownloaded
    
   
} //extension
