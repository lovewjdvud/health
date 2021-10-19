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
    var g_no: Int?
   
    // 그룹 내 인원수랑 등록 날짜 가져올때
    var count: Int?
    var m_registerday: String?
  
    // 그룹 인원 추가할때 follow 정보 가져오기
    var u_id: String?
    var u_name: String?
    var u_img: String?
    var u_no: String?
    
    // 디테일 뷰
    var d_u_id: String?
    var up_no: Int?
    var up_contains: String?
    var up_img: String?
    var up_like_count: Int?
    var up_c_count: Int?
    var p_uploadday: String?
    var d_u_img: String?
    var d_u_name: String?
    var d_u_no: Int?
    
    
    
    // 디테일 서브detailsub_u_nanme
    var detailsub_u_id: String?
    var detailsub_u_nanme: String?
    
    
    // 운동기록 가져오기
    var e_no: Int?
    var e_write: String?
    var e_muscle: Int?
    var e_fat: Int?
    var e_weight: Int?
    var e_img: String?
    var r_uploadDay: String?
    
    
    // 운동 사진 비교
   
    var  com_e_img: String?
    var  com_e_uploadDay: String?
    
    // 프로필 정보
    
    var  my_u_id: String?
    var  my_u_name: String?
    var  my_u_introduce: String?
    var  my_u_img: String?
    
    // 마이페이지 팔로잉 팔로우
    
    var  following_coun: String?
    var  followoer_count: String?
    
    // 달마다 카운트
    var  month: Int?
    var  month_count: Int?
    
    override init() {
        
        
       
       
    }
    
    
    // 달마다 카운트
    // 팔로잉 데리고오기
    init(month:Int, month_count: Int) {

       
        self.month = month
        self.month_count = month_count
       
      
 }
    
    
    // 팔로잉 데리고오기
    init(following_coun:String) {

        self.following_coun = following_coun
       
      
 }
    
    // 팔로워 데리고오기
    init(followoer_count:String) {

        self.followoer_count = followoer_count
       
      
 }
    
    
    
    // 프로피
    init(my_u_id: String, my_u_name: String, my_u_introduce: String, my_u_img: String) {

        self.my_u_id = my_u_id
        self.my_u_name = my_u_name
        self.my_u_introduce = my_u_introduce
        self.my_u_img = my_u_img
        
 }
    
    
    
    // 운동 사진 비교
    init(com_e_img: String, com_e_uploadDay: String) {

        self.com_e_img = com_e_img
        self.com_e_uploadDay = com_e_uploadDay
        
 }
    
    
    // 디테일 서브detailsub_u_nanme
    init(e_no: Int, e_write: String, e_muscle: Int, e_fat: Int, e_weight: Int, e_img: String, r_uploadDay: String) {

        self.e_no = e_no
        self.e_write = e_write
        self.e_muscle = e_muscle
        self.e_fat = e_fat
        self.e_weight = e_weight
        self.e_img = e_img
        self.r_uploadDay = r_uploadDay
        
 }
    
    // Detail 불러오는 값
    init(d_u_id: String, up_no: Int, up_contains: String, up_img:String ,up_like_count: Int, up_c_count: Int, p_uploadday: String, d_u_img: String, d_u_name: String, d_u_no: Int) {
    
     self.d_u_id = d_u_id
     self.up_no = up_no
     self.up_contains = up_contains
     self.up_img = up_img
     self.up_like_count = up_like_count
     self.up_c_count = up_c_count
     self.p_uploadday = p_uploadday
     self.d_u_img = d_u_img
     self.d_u_name = d_u_name
     self.d_u_no = d_u_no

 
 }
    
    // 디테일 서브detailsub_u_nanme
    init(detailsub_u_id: String,detailsub_u_nanme: String) {
    

        self.detailsub_u_id = detailsub_u_id
        self.detailsub_u_nanme = detailsub_u_nanme
 }
    
    // Grouplist 불러오는 값
    init(g_title: String, g_finishday: String, g_no:Int ,count: Int, m_registerday: String) {
     self.g_title = g_title
     self.g_finishday = g_finishday
     self.g_no = g_no
        self.count = count
        self.m_registerday = m_registerday

 
 }
    // 그룹 인원수 , 등록날짜 값
    init(count: Int, m_registerday: String) {
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
