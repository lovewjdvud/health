//
//  Detailsub_DB.swift
//  health
//
//  Created by Songjeongpyeong on 2021/10/08.
//

import Foundation

protocol Detailsub_DBProtocol{
    func detailsub_itemDownloaded(items: NSMutableArray, g_list_cout: Int)
}


class Detailsub_DB{
   
    var delegate: Detailsub_DBProtocol!
    var urlPath = "\(Share.urlIP)Detail_name.jsp"
   
    func DetailsublistdownItems(user_u_no: Int ,g_no: Int){
        let urlAdd = "?user_u_no=\(user_u_no)&g_no=\(g_no)"
        urlPath = urlPath + urlAdd
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        print("\(urlPath) Detail 서브 그룹리스트")
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
           
            if let detailsub_u_id = jsonElement["u_id"] as? String,
               let detailsub_u_nanme = jsonElement["u_name"] as? String
               
            
        
            {
             
                
                let query = DBModel(detailsub_u_id: detailsub_u_id, detailsub_u_nanme:detailsub_u_nanme)
                locations.add(query)
               
    
            } else {
                print("DATA is nil")
            }
            
        }
      
       
        DispatchQueue.main.async(execute: {() -> Void in
            print("사랑 4 \(locations)")
           var g_count = 0
            g_count =  locations.count
            
            self.delegate.detailsub_itemDownloaded(items: locations, g_list_cout: g_count)
            print("\(locations.count) 정평 디테일서브 카운트는??")
         
            
        })
        
    }
}


