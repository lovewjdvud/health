//
//  Detail_ViewController.swift
//  health
//
//  Created by Songjeongpyeong on 2021/10/04.
//

import UIKit

class Detail_ViewController: UIViewController {

    
    var De_g_no: Int!
    var finshdate  = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("정피영 \(De_g_no!)")
        // Cell의 크기 지정
       // listTableView.rowHeight = 95
        self.title = "프로젝트 완료까지 \(finshdate)일 남았습니다"
        
        // Do any additional setup after loading the view.
    }
    

    
    
    

}
