//
//  Mypagelist.swift
//  health
//
//  Created by Songjeongpyeong on 2021/10/19.
//

import Foundation



protocol MypagelistProtocol{
    func MypagelistitemDownloaded(items: NSMutableArray, g_list_cout: Int)
}


class Mypagelist{
   
    var delegate: MypagelistProtocol!
    var urlPath = "\(Share.urlIP)Mypagelist.jsp"
   
    func MypagelistlistdownItems(user_u_no: Int){
        let urlAdd = "?user_u_no=\(user_u_no)"
        urlPath = urlPath + urlAdd
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        print("\(urlPath) mypagelist 그룹리스트")
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
           
            if let my_u_id = jsonElement["u_id"] as? String,
               let my_u_name = jsonElement["u_name"] as? String,
               let my_u_introduce = jsonElement["u_introduce"] as? String,
               let my_u_img = jsonElement["u_img"] as? String
            
        
            {
             
                
                let query = DBModel(my_u_id:my_u_id, my_u_name:my_u_name ,my_u_introduce:my_u_introduce ,my_u_img:my_u_img)
                locations.add(query)
        
            } else {
                print("DATA is nil")
            }
            
        }
      
       
        DispatchQueue.main.async(execute: {() -> Void in
            print("사랑 4 \(locations)")
           var g_count = 0
            g_count =  locations.count
            
            self.delegate.MypagelistitemDownloaded(items: locations, g_list_cout: g_count)
            print("\(locations.count) 정평 마이페이지릿트 카운트는??")
         
            
        })
        
    }
}


