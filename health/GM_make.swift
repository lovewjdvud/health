//
//  GM_make.swift
//  health
//
//  Created by Songjeongpyeong on 2021/09/29.
//

import Foundation

class GM_make{
    //jsonmodel 이 portocol 을 가지고 잇어야 함!?
   
    var urlPath = "\(Share.urlIP)GM_mamke.jsp"
    
    func GM_makeItems(finiday: String, title: String ,idlist: Array<String>, user_u_no: Int , currentedate: String) -> Bool{
        var result: Bool = true
        let urlAdd = "?finiday=\(finiday)&title=\(title)&user_u_no=\(user_u_no)&currentedate=\(currentedate)&idlist=\(idlist)"
        urlPath = urlPath + urlAdd // urlpath는 진짜 URL
        //한글 url encoding
       
       let ur  = urlPath.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)! // 배열 인코딩
        print("\(ur) 여기는 GM_make" )
        print("")
        print("\(urlPath) 여기는 GM_make" )
        
        // 서버에서 데이터 받아오는 동안 다른 일을 해야지!
        let url: URL = URL(string: ur)!
        let defaultSession = Foundation.URLSession.init(configuration: URLSessionConfiguration.default) //Foundation은 지워도 된다
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to insert data")
                result = false
            }else{
                print("Data is insert") // 다운로드 된거로 json 으로 감?
                result = true
            }
            
        }
        
        task.resume() //resume을 실해하면 json으로 데이터를 가져온다
        return result
    }
}
