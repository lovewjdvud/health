//
//  AddGroupViewController.swift
//  health
//
//  Created by Songjeongpyeong on 2021/09/02.
//

import UIKit


var itemtest = ["ss"]
protocol AddGroupProticol {
   
    func btn_add_invite2(index: Int ,invite_id: String,invite_name: String,invite_img: String)
}

protocol AddGroupProticol2 {
    func btn_add_invite(test1: Int ,test2: String,test3: String,test4: String)
    
}





class AddGroupViewController: UIViewController {

    var add_id =  [Int : String]()
    var add_name =  [Int : String]()
    var add_img =  [Int : String]()
    var test1 =  0
    var test2 = ""
    var test3 = ""
    var test4 = ""
    
    var delegate: AddGroupProticol2?
    @IBOutlet weak var tv_addGroup: UITableView!
    @IBOutlet weak var addGroup_tf_title: UITextField!
    @IBOutlet weak var btn_addpeople: UIButton!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        btn_addpeople.layer.cornerRadius = 30 // 버튼 모서리 깍기
        tf_title()
      
    } //viewDidLoad
    
    override func viewWillAppear(_ animated: Bool){

        print("값이 작아")
      
        tv_addGroup.delegate = self
        tv_addGroup.dataSource = self // 테이블뷰 실제 실헹
        self.tv_addGroup.reloadData()
       
        
        
       
    }
    
   
        
    
    // 텍스트 필드 밑에 라인 넣기
    func tf_title()  {

        let border = CALayer()
        let width = CGFloat(1.0)
        
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: addGroup_tf_title.frame.size.height - width, width:  addGroup_tf_title.frame.size.width, height: addGroup_tf_title.frame.size.height)
          
        border.borderWidth = width
        addGroup_tf_title.layer.addSublayer(border)
        addGroup_tf_title.layer.masksToBounds = true
      
        self.addGroup_tf_title.becomeFirstResponder() // 화면 올리기

    }//tf_title

    
    //MARK: 키보드 내리는 소스
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    
    

    
    
} //AddGroupViewController





//                                         테이블뷰 시작                                                                     //

extension AddGroupViewController: UITableViewDelegate, UITableViewDataSource{
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
    
        return index_member.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addMemberCell", for: indexPath) as! C_memenAddTableViewCell
        
     
        print("\(indexPath.row) 여기는 팀원 추가 인덱스")
        let numBer = index_down[indexPath.row]
 
       
        cell.lbl_id_memberAdd.text? = "\(id_member[numBer] ?? "dd")"
        cell.lbl_name_memberAdd.text? = "\(name_member[numBer] ?? "실패")"
        print("\(id_member[numBer] ?? "dd")sss")
     
//
        DispatchQueue.global().async {
            guard let url = URL(string: "\(Share.imgurl)\(img_member[numBer] ?? "실패")") else { return }
            print("\(url)")

            guard let data = try? Data(contentsOf: url) else {
                return
            }
            DispatchQueue.main.async {
                cell.img_memberAdd.image = UIImage(data: data)
            }
        }
                cell.selectionStyle = .none
        
        return cell
    
    }// 테이블 뷰
    
    // 셀 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath2: IndexPath) {
                if let cell = tableView.cellForRow(at: indexPath2) {
                    let backgroundView = UIView()
                    backgroundView.backgroundColor = UIColor.white
                    cell.selectedBackgroundView = backgroundView
           }
        
    
}
}
//                                         테이블뷰 끝                                                                  


extension AddGroupViewController: EditDelegate{
    func didMessageEditDone3(_ controller: C_FollowTableViewCell, id_protocol: Dictionary<Int, String>, name_protocol: Dictionary<Int, String>, img_protocol: Dictionary<Int, String>) {
        add_id = id_protocol
        
    }
}