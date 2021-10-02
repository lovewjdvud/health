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
   
    var currentdate_make = ""  // 현재 날짜
    var add_id =  [Int : String]()
    var add_name =  [Int : String]()
    var add_img =  [Int : String]()
    var test1 =  0
    var test2 = ""
    var test3 = ""
    var test4 = ""
    
    var g_finiday = "" //목표날짜
    
    
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
       
        print("\(id_member) ADD")
        print("\(name_member) ADD")
        print("\(img_member) ADD")
        print("\(index_down) ADD")
        sm_num = 0
        
       
    }
    
    @IBAction func datePicker_finishday(_ sender: UIDatePicker) {
        
            let datePickerView = sender
            let formatter = DateFormatter()
            
            formatter.locale = Locale(identifier: "ko")
          //  formatter.dateFormat =  "yyyy-MM-dd a hh:mm"  //24시간 HH
            formatter.dateFormat =  "yyyy-MM-dd"  //24시간 HH

        
        g_finiday = "\(formatter.string(from: datePickerView.date))"
         
    }
    
    
    
    @IBAction func btn_group_make(_ sender: UIButton) {
        
        
            
           if g_finiday == "" {
            let Edict = UIAlertController(title: "경고", message: "날짜를 입력주세요!", preferredStyle: .alert)
            let EdicCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            Edict.addAction(EdicCancel)
            present(Edict, animated: true, completion: nil)

        }else if addGroup_tf_title.text! == "" {
            let Edict = UIAlertController(title: "경고", message: "제목을 입력해주세요!", preferredStyle: .alert)
            let EdicCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            Edict.addAction(EdicCancel)
            present(Edict, animated: true, completion: nil)
            
        } else if id_member.count <= 0  {
            let Edict = UIAlertController(title: "경고", message: "혼자 진행하시겠습니까?",  preferredStyle: .alert)
         
            let Edictallow = UIAlertAction(title: "예", style: .default, handler:  { [self]ACTION in group_make()})
            let EdicCancel = UIAlertAction(title: "아니요", style: .destructive, handler: nil)
          
            Edict.addAction(Edictallow)
            Edict.addAction(EdicCancel)
           
            present(Edict, animated: true, completion: nil)
            
        } else if g_finiday != "" && id_member.count > 0{
        //Action
        let Edict = UIAlertController(title: "그룹 생성", message: "그룹을 생성하시겠습까??", preferredStyle: .alert)
        
    
        let EdicCancel = UIAlertAction(title: "아니오", style: .destructive, handler: nil)
        let Edictallow = UIAlertAction(title: "예", style: .default, handler:  { [self]ACTION in group_make()})
 //       let lampOnAction = UIAlertAction(title: "아니요 켭니다", style: .default, handler: { [self]ACTION in nil})
     
      //  EdictCancel.setValue(UIColor(red: CGFloat(GL_RED), green: nil, blue: nil, alpha: nil), forKey: "title")
              
               // lampremove.addAction(lampOnAction)
        Edict.addAction(Edictallow)
        Edict.addAction(EdicCancel)
      
                present(Edict, animated: true, completion: nil)
        
        }
        
        
        
        
    }
    
    func group_make()  {
    
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        currentdate_make = "\(dateFormatter.string(from: date))"
        
        
        
        let gm_Follow_o = GM_make()
    
        
        
        //finiday: "\(g_finiday)", title: "\(addGroup_tf_title.text!)" ,idlist: subway2_down
        
        let result =  gm_Follow_o.GM_makeItems(finiday: "\(g_finiday)", title: "\(addGroup_tf_title.text!)", idlist: subway2_down, user_u_no: Share.user_no, currentedate: currentdate_make)
       
        if result{
      
            print("성공")
            
            self.navigationController?.popViewController(animated: true)
            
        } else  {
            
            print("실패")
        }
        
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
    
        return id_member.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addMemberCell", for: indexPath) as! C_memenAddTableViewCell
        
     
        print("\(indexPath.row) 여기는 팀원 추가 인덱스")
        
       // let numBer = index_down[indexPath.row]
        
           print("\(id_member) 여기는 팀원 추가 아이디")
       
        print("\(key) 여기는 팀원 팔로윙")
        print("\(f_key) 여기는 팀원 팔로워")
        print("\(subway2_down) 여기는 팀원 최종 키 추가")
        
         
       
      
       
        cell.lbl_id_memberAdd.text? = "\(id_member[subway2_down[indexPath.row]] ?? "dd")"
        cell.lbl_name_memberAdd.text? = "\(name_member[subway2_down[indexPath.row]] ?? "실패")"
        
        
    
     
//
        DispatchQueue.global().async {
            guard let url = URL(string: "\(Share.imgurl)\(img_member[subway2_down[indexPath.row]] ?? "실패")") else { return }
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
