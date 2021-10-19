//
//  Cal_BottomViewController.swift
//  health
//
//  Created by Songjeongpyeong on 2021/10/19.
//

import UIKit
import MaterialComponents.MaterialBottomSheet

class Cal_BottomViewController: UIViewController {

    @IBOutlet weak var btn_cho: UIButton!
    
    @IBOutlet weak var datepicker_bottom: UIDatePicker!
    var bottom_chodate_DatePicker = "" //DatePicker에서 고른 값
    var select_date_FSCalendar = "" // FSCalendar에서 고른 값
    var currentDate = "" //
    var cal_date_array: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        btn_cho.layer.cornerRadius = 30 // 버튼
        
        print("\(select_date_FSCalendar) \(bottom_chodate_DatePicker) ckstlr")
        print("\(cal_date_array)  ckstlr")
    } //viewDidLoad
    
    
    
    
    @IBAction func btn_cho_actiuon(_ sender: UIButton) {
        
        
        
        
        if bottom_chodate_DatePicker == "" {
          
            let Edict = UIAlertController(title: "경고", message: "날짜를 선택해 주세요", preferredStyle: .alert)
            let EdicCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            Edict.addAction(EdicCancel)
            present(Edict, animated: true, completion: nil)
            
  
        }

        
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        let  limit_current = "\(dateFormatter.string(from: date))"
        print(dateFormatter.string(from: date))

        if bottom_chodate_DatePicker == "" {
            bottom_chodate_DatePicker = limit_current
        }
        
        let current = dateFormatter.date(from:"\(limit_current)")!
        let datrPicker = dateFormatter.date(from:"\(bottom_chodate_DatePicker)")!
        
        
        
        if  bottom_chodate_DatePicker ==  select_date_FSCalendar {
            
            let Edict = UIAlertController(title: "경고", message: "같은 날짜를 선택 하실 수 없습니다", preferredStyle: .alert)
            let EdicCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            Edict.addAction(EdicCancel)
            present(Edict, animated: true, completion: nil)
        
        }else if current < datrPicker || cal_date_array.contains(bottom_chodate_DatePicker) == false {
            
            let Edict = UIAlertController(title: "경고", message: "기록이 없는 날짜 입니다", preferredStyle: .alert)
            let EdicCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            Edict.addAction(EdicCancel)
            present(Edict, animated: true, completion: nil)
            
        
            
        }
        
        
        
    } //btn_cho_actiuon
    
    
    
    
    
    @IBAction func picker_bottom(_ sender: UIDatePicker) {
        let datePickerView = sender
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "ko")
      //  formatter.dateFormat =  "yyyy-MM-dd a hh:mm"  //24시간 HH
        formatter.dateFormat =  "yyyy-MM-dd"  //24시간 HH

    
        bottom_chodate_DatePicker = "\(formatter.string(from: datePickerView.date))"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

         self.view.endEditing(true)

   }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "sgCom" {
          
          let comparView  = segue.destination as! CAL__ComparisonViewController
          
            comparView.select_date_FSCalendar = select_date_FSCalendar
            comparView.bottom_cho_Datepicker = bottom_chodate_DatePicker
         
        }
    }
    
    
    
} // Cal_BottomViewController
