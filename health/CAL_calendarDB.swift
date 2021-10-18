//
//  CAL_calendarDB.swift
//  health
//
//  Created by Songjeongpyeong on 2021/10/18.
//

import Foundation

protocol CAL_calendarDBProtocol{
    func calitemDownloaded(items: NSMutableArray, g_list_cout: Int)
}


class CAL_calendarDB{
   
    var delegate: CAL_calendarDBProtocol!
    var urlPath = "\(Share.urlIP)Calendarlist.jsp"
   
    func CAL_calendarDBistdownItems(user_u_no: Int){
        let urlAdd = "?user_u_no=\(user_u_no)"
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
           
            if let e_no = jsonElement["e_no"] as? String,
               let e_write = jsonElement["e_write"] as? String,
               let e_muscle = jsonElement["e_muscle"] as? String,
               let e_fat = jsonElement["e_fat"] as? String,
               let e_weight = jsonElement["e_weight"] as? String,
               let e_img = jsonElement["e_img"] as? String,
               let r_uploadDay = jsonElement["r_uploadDay"] as? String
            
        
            {
             
                
                let query = DBModel(e_no: Int(e_no)!, e_write: e_write, e_muscle: Int(e_muscle)!, e_fat: Int(e_fat)!, e_weight: Int(e_weight)!, e_img: e_img, r_uploadDay: r_uploadDay)
                locations.add(query)
                
    
            } else {
                print("DATA is nil")
            }
            
        }
      
       
        DispatchQueue.main.async(execute: {() -> Void in
            print("사랑 4 \(locations)")
           var g_count = 0
            g_count =  locations.count
            
            self.delegate.calitemDownloaded(items: locations, g_list_cout: g_count)
            print("\(locations.count) 찬식 Clalen 카운트는??")
         
            
        })
        
    }
}


