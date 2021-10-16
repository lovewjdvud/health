//
//  Detail_DB.swift
//  health
//
//  Created by Songjeongpyeong on 2021/10/05.
//

import Foundation

protocol Detail_DBProtocol{
    func detailitemDownloaded(items: NSMutableArray, g_list_cout: Int)
}


class Detail_DB{
   
    var delegate: Detail_DBProtocol!
    var urlPath = "\(Share.urlIP)Detail.jsp"
   
    func Detail_DBlistdownItems(user_u_no: Int ,g_no: Int,currentdate: String){
        let urlAdd = "?user_u_no=\(user_u_no)&g_no=\(g_no)&currentdate=\(currentdate)"
        urlPath = urlPath + urlAdd
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        print("\(urlPath) Detail_DB 그룹리스트")
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
           
            if let d_u_id = jsonElement["u_id"] as? String,
               let up_no = jsonElement["up_no"] as? String,
               let up_contains = jsonElement["up_contains"] as? String,
               let up_img = jsonElement["up_img"] as? String,
               let up_like_count = jsonElement["up_like_count"] as? String,
               let up_c_count = jsonElement["up_c_count"] as? String,
               let p_uploadday = jsonElement["p_uploadday"] as? String,
               let d_u_img = jsonElement["u_img"] as? String,
               let d_u_name = jsonElement["u_name"] as? String,
               let d_u_no = jsonElement["u_no"] as? String
            
        
            {
             
                
                let query = DBModel(d_u_id: d_u_id, up_no: Int(up_no)!, up_contains: up_contains, up_img: up_img, up_like_count: Int(up_like_count)!, up_c_count: Int(up_c_count)!, p_uploadday: p_uploadday,d_u_img: d_u_img, d_u_name:d_u_name,d_u_no: Int(d_u_no)!)
                locations.add(query)
                print("사랑 아이디 \(d_u_id)")
                print("사랑 3 \(up_no)")
                print("사랑 3 \(up_contains)")
                print("사랑 3 \(up_img)")
                print("사랑 3 \(up_like_count)")
                print("사랑 3 \(up_c_count)")
                print("사랑 3 \(p_uploadday)")
                print("사랑 끝 \(d_u_img)")
                print("사랑 끝 \(d_u_name)")
                print("사랑 끝 \(d_u_no)")
    
            } else {
                print("DATA is nil")
            }
            
        }
      
       
        DispatchQueue.main.async(execute: {() -> Void in
            print("사랑 4 \(locations)")
           var g_count = 0
            g_count =  locations.count
            
            self.delegate.detailitemDownloaded(items: locations, g_list_cout: g_count)
            print("\(locations.count) 정평 디테일 카운트는??")
         
            
        })
        
    }
}


