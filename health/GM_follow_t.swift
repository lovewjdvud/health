//
//  GM_follow_t.swift
//  health
//
//  Created by Songjeongpyeong on 2021/09/24.
//

import Foundation

protocol GM_Follow_tProtocol{
    func GM_Follow_titemDownloaded(follow_t_items: NSArray, g_list_cout: Int)
}


class GM_Follow_t{
    
    var delegate: GM_Follow_tProtocol!
    var urlPath = "\(Share.urlIP)GM_followlist.jsp"
   
    func GM_Follow_tdownItems(user_u_no: Int, check: Int, searchTexts: String){
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
               let u_img = jsonElement["u_img"] as? String
        
            {
                let query = DBModel(u_id: u_id, u_name: u_name, u_img: u_img)
                locations.add(query)
              
               
            } else {
                print("DATA is nil")
            }
            
        }
      
        
        DispatchQueue.main.async(execute: {() -> Void in
            
           var g_count = 0
            g_count =  locations.count
            self.delegate.GM_Follow_titemDownloaded(follow_t_items: locations, g_list_cout: g_count)
            print("\(locations.count) 팔로잉 팔로우수는????")
            
        })
        
    }
}







