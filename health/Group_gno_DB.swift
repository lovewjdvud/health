//
//  Group_gno_DB.swift
//  health
//
//  Created by Songjeongpyeong on 2021/09/02.
//

import Foundation

protocol Group_gno_DBProtocol{
    func G_noitemDownloaded(items: NSMutableArray)
}


class Group_gno_DB{
    
    var delegate: Group_gno_DBProtocol!
    var urlPath = "\(Share.urlIP)Group_Usernum.jsp"
   
    
    
    func Group_gno_DBdownItems(user_u_no: Int){
        let urlAdd = "?user_u_no=\(user_u_no)"
        
        urlPath = urlPath + urlAdd
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        print("URL is : \(urlPath)")
        print("희지 \(urlPath)")
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
            if let m_registerday = jsonElement["m_registerday"] as? String,
               let count = jsonElement["count"] as? String
            {
                let query = DBModel(count: count, m_registerday: m_registerday)
              
                locations.add(query)
            } else {
                print("DATA is nil")
            }
        }
      
        
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.G_noitemDownloaded(items: locations)
    
        })
        
    }
}


