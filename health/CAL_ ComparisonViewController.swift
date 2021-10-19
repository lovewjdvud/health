//
//  CAL_ ComparisonViewController.swift
//  health
//
//  Created by Songjeongpyeong on 2021/10/19.
//

import UIKit

class CAL__ComparisonViewController: UIViewController {

    var bottom_cho_Datepicker = "" //DatePicker에서 고른 값
    var select_date_FSCalendar = "" // FSCalendar에서 고른 값
    var com_count: Int!
    
    var com_db_date = [String]()
    var com_db_img = [String]()
    
    var Dbdate1:Date!
    var Dbdate2:Date!
    
    @IBOutlet weak var img_big: UIImageView!
    @IBOutlet weak var img_small: UIImageView!
    
    @IBOutlet weak var lbl_small: UILabel!
    @IBOutlet weak var lbl_big: UILabel!
    
    
    
    @IBOutlet weak var btn_com: UIButton!
    
    
    var Cal_comparlistItem: NSMutableArray = NSMutableArray()// DB에서 값 받아오는 곳
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
       // btn_com.isHidden = true
        print("\(bottom_cho_Datepicker) \(select_date_FSCalendar) ckstlr")

        
        // DB  불러 오기
        let cal_comparlistDB = CAL_compar()
        cal_comparlistDB.delegate = self
        cal_comparlistDB.CAL_compardownItems(bottom_cho_Datepicker: bottom_cho_Datepicker, select_date_FSCalendar: select_date_FSCalendar)

        date_lbl()
        
    } //viewDidLoad
    
    override func viewWillAppear(_ animated: Bool){
        
        com_db_date.removeAll()
        com_db_img.removeAll()
    } //viewWillAppear
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)

   } //touchesBegan
    
    
    
    @IBAction func btn_back(_ sender: UIButton) {
        
        
          let vcName = self.storyboard?.instantiateViewController(withIdentifier: "Calendar_Vc")
                  vcName?.modalPresentationStyle = .fullScreen //전체화면으로 보이게 설정
                  vcName?.modalTransitionStyle = .crossDissolve //전환 애니메이션 설정
                  self.present(vcName!, animated: true, completion: nil)
   
    } //btn_back
    
    
    
    func date_lbl()  {
        
        
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.timeZone = TimeZone.current
              
                print(dateFormatter.string(from: date))
        
                let select_fc = dateFormatter.date(from:"\(select_date_FSCalendar)")!
                let select_datepicker = dateFormatter.date(from:"\(bottom_cho_Datepicker)")!
        
        
        //    let item3: DBModel = DetaillistItem[indexPath.row] as! DBModel print("\(Detail_DB_count!) DB 사랑 테이블")
        
      
            
        if select_fc >  select_datepicker{
            
            lbl_small.text? = "\(bottom_cho_Datepicker)일"
            lbl_big.text? = "\(select_date_FSCalendar)일"
            
           // let small = "small"
            
        //    img(img_name: com_item.com_e_img!, datepicker:bottom_cho_Datepicker,FSCalendar:select_date_FSCalendar, other: small)
            
            
            
            
        } else if select_fc < select_datepicker{
         

            lbl_small.text? = "\(select_date_FSCalendar)일"
            lbl_big.text? = "\(bottom_cho_Datepicker)일"
            
        } //if
        
   
            
    } //date_lbl
    
    
    func img()  {
        
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.timeZone = TimeZone.current
              
                print(dateFormatter.string(from: date))
        
        
                    
                Dbdate1 = dateFormatter.date(from:"\(com_db_date[0])")!
                Dbdate2 = dateFormatter.date(from:"\(com_db_date[1])")!
        
        
        
        if Dbdate1 > Dbdate2 {
            DispatchQueue.global().async {
                guard let url = URL(string: "\(Share.imgurl)\(self.com_db_img[1])") else { return }
                print("\(url)")

                guard let data = try? Data(contentsOf: url) else {
                    return
                }
                DispatchQueue.main.async {
                    self.img_small.image = UIImage(data: data)
                }
            }// DispatchQueue
            
            
            DispatchQueue.global().async {
                guard let url = URL(string: "\(Share.imgurl)\(self.com_db_img[0])") else { return }
                print("\(url)")

                guard let data = try? Data(contentsOf: url) else {
                    return
                }
                DispatchQueue.main.async {
                    self.img_big.image = UIImage(data: data)
                }
            }// DispatchQueue
        
        } else if  Dbdate1 < Dbdate2 {
            DispatchQueue.global().async {
                guard let url = URL(string: "\(Share.imgurl)\(self.com_db_img[0])") else { return }
                print("\(url)")

                guard let data = try? Data(contentsOf: url) else {
                    return
                }
                DispatchQueue.main.async {
                    self.img_small.image = UIImage(data: data)
                }
            }// DispatchQueue
            
            
            DispatchQueue.global().async {
                guard let url = URL(string: "\(Share.imgurl)\(self.com_db_img[1])") else { return }
                print("\(url)")

                guard let data = try? Data(contentsOf: url) else {
                    return
                }
                DispatchQueue.main.async {
                    self.img_big.image = UIImage(data: data)
                }
            }
        }
        
        
        
    } // img
    
    
} //CAL__ComparisonViewController



// Grouplistg 테이블의 값들 추출
extension CAL__ComparisonViewController : CAL_comparDBProtocol {
    func CAL_comparitemDownloaded(items: NSMutableArray, g_list_cout: Int) {
       
        Cal_comparlistItem = items
        com_count = g_list_cout-1
        
        print("\(g_list_cout) ckstlr")
        
   
        for i in 0...com_count {
            let com_item: DBModel = Cal_comparlistItem[i] as! DBModel
            
            com_db_date.append(com_item.com_e_uploadDay!)
            com_db_img.append(com_item.com_e_img!)
            print("\(com_item.com_e_img!)")
            
        }
       img()
        
    }
    
    
    }

