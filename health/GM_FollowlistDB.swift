//
//  GM_Followlist.swift
//  health
//
//  Created by Songjeongpyeong on 2021/09/06.
//

import Foundation

protocol GM_FollowlistDBProtocol{
    func GM_FollowlistDBitemDownloaded(items: NSArray, g_list_cout: Int)
}


class GM_FollowlistDB{
    
    var delegate: GM_FollowlistDBProtocol!
    var urlPath = "\(Share.urlIP)GM_followlist.jsp"
   
    func GM_FollowlistDBdownItems(user_u_no: Int, check: Int, searchTexts: String){
        let urlAdd = "?user_u_no=\(user_u_no)&check=\(check)&searchTexts=\(searchTexts)"
        
      
        urlPath = urlPath + urlAdd
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        print("URL is : \(urlPath) 값이" )
        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession(configuration: .default)
        let task = defaultSession.dataTask(with: url){data, response, error in
            if error != nil{
                print("Failed to download data")
            }else{
                self.parseJSON(data!)
                
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
            if let u_id = jsonElement["u_id"] as? String,
               let u_name = jsonElement["u_name"] as? String,
               let u_img = jsonElement["u_img"] as? String,
               let u_no = jsonElement["u_no"] as? String
        
            {
                let query = DBModel(u_id: u_id, u_name: u_name, u_img: u_img,u_no:u_no)
                locations.add(query)
              
               
            } else {
                print("DATA is nil")
            }
            
        }
      
        
        DispatchQueue.main.async(execute: {() -> Void in
            
           var g_count = 0
            g_count =  locations.count
            print("사랑 4 \(locations)")
            self.delegate.GM_FollowlistDBitemDownloaded(items: locations, g_list_cout: g_count)
            print("\(locations.count) 팔로잉 팔로우수는????")
            
        })
        
    }
}







