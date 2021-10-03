//
//  DBModel.swift
//  health
//
//  Created by Songjeongpyeong on 2021/09/02.
//

import Foundation

class DBModel: NSObject{
   
    // 그룹 목록 가져올때
    var g_title: String?
    var g_finishday: String?
    var g_no: String?
   
    // 그룹 내 인원수랑 등록 날짜 가져올때
    var count: String?
    var m_registerday: String?
  
    // 그룹 인원 추가할때 follow 정보 가져오기
    var u_id: String?
    var u_name: String?
    var u_img: String?
    var u_no: String?
    
    override init() {
        
    }
    
    // Grouplist 불러오는 값
    init(g_title: String, g_finishday: String, g_no:String) {
     self.g_title = g_title
     self.g_finishday = g_finishday
     self.g_no = g_no
 
 }
    // 그룹 인원수 , 등록날짜 값
    init(count: String, m_registerday: String) {
     self.count = count
     self.m_registerday = m_registerday

 
 } //그룹 인원 추가할때 follow 정보 가져오기
    
    //
    init(u_id: String, u_name: String, u_img:String, u_no:String) {
     self.u_id = u_id
     self.u_name = u_name
     self.u_img = u_img
     self.u_no = u_no
 
 }
    
    // 팔로우 o , t
    init(u_id: String, u_name: String, u_img:String) {
     self.u_id = u_id
     self.u_name = u_name
     self.u_img = u_img

 
 }

    
    
    
}
