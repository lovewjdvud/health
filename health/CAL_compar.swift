//
//  CAL_compar.swift
//  health
//
//  Created by Songjeongpyeong on 2021/10/19.
//

import Foundation


protocol CAL_comparDBProtocol{
    func CAL_comparitemDownloaded(items: NSMutableArray, g_list_cout: Int)
}


class CAL_compar{
   
    var delegate: CAL_comparDBProtocol!
    var urlPath = "\(Share.urlIP)Cal__Comparison.jsp"
   
    func CAL_compardownItems(bottom_cho_Datepicker: String, select_date_FSCalendar: String){
        let urlAdd = "?user_u_no=\(Share.user_no)&bottom_cho_Datepicker=\(bottom_cho_Datepicker)&select_date_FSCalendar=\(select_date_FSCalendar)"
        urlPath = urlPath + urlAdd
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        print("\(urlPath) CAL_calendarDB 그룹리스트")
        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession(configuration: .default)
        let task = defaultSession.dataTask(with: url){data, response, error in
            if error != nil{
                print("Failed to download data")
            }else{
                self.parseJSON(data!)
                print("사랑 2")
                
            }
            
        }
        print("사랑 타스트 시작")
        task.resume() //resume을 실해하면 json으로 데이터를 가져온다
        print("사랑 타스크 끝")
    }
    
    
    
    //어싱크 방식 은 dispatch 가 들어감
    
    
    
    
    func parseJSON(_ data: Data) {
        
        var jsonResult = NSArray()
        do{
            //swift 에서 json 쓰는 방법
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
     
        }catch let error as NSError{
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        
        
        
        for i in 0..<jsonResult.count{
            
            jsonElement = jsonResult[i] as! NSDictionary
           
            if let com_e_img = jsonElement["e_img"] as? String,
               let com_e_uploadDay = jsonElement["e_uploadDay"] as? String
            
        
            {
             
                
                let query = DBModel(com_e_img: com_e_img, com_e_uploadDay: com_e_uploadDay)
                locations.add(query)
                
    
            } else {
                print("DATA is nil")
            }
            
        }
      
       
        DispatchQueue.main.async(execute: {() -> Void in
            print("사랑 4 \(locations)")
           var g_count = 0
            g_count =  locations.count
            
            self.delegate.CAL_comparitemDownloaded(items: locations, g_list_cout: g_count)
            print("\(locations.count) 찬식 Clalen 카운트는??")
         
            
        })
        
    }
}


