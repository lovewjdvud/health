//
//  GrouplistDB.swift
//  health
//
//  Created by Songjeongpyeong on 2021/09/02.
//

import Foundation


protocol GrouplistDBProtocol{
    func itemDownloaded(items: NSMutableArray, g_list_cout: Int)
}


class GrouplistDB{
    
    var delegate: GrouplistDBProtocol!
    var urlPath = "\(Share.urlIP)Grouplist.jsp"
   
    func GrouplistDBdownItems(user_u_no: Int){
        let urlAdd = "?user_u_no=\(user_u_no)"
        urlPath = urlPath + urlAdd
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        print("\(urlPath)정평 그룹리스트")
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
        
        task.resume() //resume을 실해하면 json으로 데이터를 가져온다
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
           
            if let g_title = jsonElement["g_title"] as? String,
               let g_finishday = jsonElement["g_finishday"] as? String,
               let g_no = jsonElement["g_no"] as? String,
               let m_registerday = jsonElement["m_registerday"] as? String,
               let count = jsonElement["count"] as? String
            
        
            {
                let query = DBModel(g_title: g_title,g_finishday: g_finishday, g_no: Int(g_no)!,count: Int(count)!, m_registerday: m_registerday)
                locations.add(query)
              
                print("사랑 3")
            } else {
                print("DATA is nil")
            }
            
        }
      
       
        DispatchQueue.main.async(execute: {() -> Void in
            
           var g_count = 0
            g_count =  locations.count
            self.delegate.itemDownloaded(items: locations, g_list_cout: g_count)
            print("\(locations.count) 정평 그룹리스트 카운트는??")
            print("사랑 4")
            
        })
        
    }
}


