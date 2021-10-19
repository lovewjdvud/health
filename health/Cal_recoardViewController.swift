//
//  Cal_recoardViewController.swift
//  health
//
//  Created by Songjeongpyeong on 2021/10/18.
//

import UIKit
import YPImagePicker
import Alamofire

class Cal_recoardViewController: UIViewController {

    
    @IBOutlet weak var img_Record: UIImageView!
    

 
    @IBOutlet weak var tf_muscle_recoard: UITextField!
    @IBOutlet weak var tf_fat_recoard: UITextField!
    
    @IBOutlet weak var tf_weight_recoard: UITextField!
    @IBOutlet weak var textView_recoard: UITextView!
    
    var filename_img = ""
    var textView_write = ""
    
    var imageData: Data!
    
    var currentdate_recoard: String!
    var selectday_recoed: Date!
    var selectday_recoed2: String!
    override func viewDidLoad() {
        super.viewDidLoad()


        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        currentdate_recoard = "\(dateFormatter.string(from: date))"
        
        
        
    } //viewDidLoad
    

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

         self.view.endEditing(true)

   }
    
   // 사진 접근 버튼
    @IBAction func btn_img(_ sender: UIButton) {
        photo() // 갤러리 접근
        
    }
    
    
    
    @IBAction func btn_recoard_finish(_ sender: UIButton) {
       
        if img_Record.image == nil {
         let Edict = UIAlertController(title: "경고", message: "사진을 선택헤주세요", preferredStyle: .alert)
         let EdicCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
         Edict.addAction(EdicCancel)
         present(Edict, animated: true, completion: nil)

         
     } else {
     //Action
     let Edict = UIAlertController(title: "운동 클리어!", message: "기록 하시겠습니까?", preferredStyle: .alert)
     
 
     let EdicCancel = UIAlertAction(title: "아니오", style: .destructive, handler: nil)
     let Edictallow = UIAlertAction(title: "예", style: .default, handler:  { [self]ACTION in uploadstart()}) // 업로드 함수 넣기
//       let lampOnAction = UIAlertAction(title: "아니요 켭니다", style: .default, handler: { [self]ACTION in nil})
  
   //  EdictCancel.setValue(UIColor(red: CGFloat(GL_RED), green: nil, blue: nil, alpha: nil), forKey: "title")
           
            // lampremove.addAction(lampOnAction)
     Edict.addAction(Edictallow)
     Edict.addAction(EdicCancel)
   
             present(Edict, animated: true, completion: nil)
     
     }
     
     
     
        
    }
    
    
    
    
    // 갤러리러 들어가는 방법
    func photo()  {
        // 카메라 라이브러리 설정
        var config = YPImagePickerConfiguration()
       // config.screens = [.library, .photo, .video] 카메라 비디오 사용시
        config.screens = [.library]
        print("1")
        let picker = YPImagePicker(configuration: config)
        // 사진 선택시
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
//                print(photo.fromCamera) // Image source (camera or library)
//                print(photo.image) // Final image selected by the user
//                print(photo.originalImage) // original image selected by the user, unfiltered
//                print(photo.modifiedImage) // Transformed image, can be nil
//                print(photo.exifMeta) // Print exif meta data of original image.
                
                // 프사 이미지 넣기
                self.img_Record.image = photo.image
            }
          
            // 피커 창 닫기
            picker.dismiss(animated: true, completion: nil)
           
            
           
        }
        // 사진 선택 창 보여주가
        present(picker, animated: true, completion: nil)

    } //photo

    
    
    // 사진 업로드 과정
    func uploadstart()  {
        
        filename_img = "\(selectday_recoed2!)\(Share.user_no).jpg"
        
        textView_write = textView_recoard.text! // 텍스트뷰에 쓴글 가져오기
        print("\(textView_write) 신찬식 텍스트")
        print("\(filename_img) 신찬식 이미지")
        guard  img_Record.image != nil else {  // 이미지 널값 구분
          print("실패")
            return
        }// 바이트 추출
        imageData = self.img_Record.image?.jpegData(compressionQuality: 1) // 이미지 jpg데이터로 변형
        
        guard self.imageData != nil else {
            print("널값")
        return
        }
        
        var urlpath =  "\(Share.urlIP)Cal_recoard.jsp"// 업로드할 url
        let urlinform = "?user_u_no=\(Share.user_no)&e_weight=\(tf_weight_recoard.text!)&e_fat=\(tf_fat_recoard.text!)&e_muscle=\(tf_muscle_recoard.text!)&e_img=\(filename_img)&e_write=\(textView_write)&e_uploadDay=\(selectday_recoed2!)"
        
        urlpath = urlpath + urlinform
        
        let url = urlpath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        print("\(urlpath) 신찬식")
        
        
        
        // 본격 업로드 시작
        AF.upload(multipartFormData: { multipartFormData in
        
            multipartFormData.append(self.imageData, withName:"Name", fileName: "\(self.filename_img)", mimeType: "image/jpg")
            
        }, to: URL(string: url)!)
        .responseJSON { response in
            print("\(response) ")
            
            Loading_Call.showLoading()
             DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                Loading_Call.hideLoading()
                 self.navigationController?.popViewController(animated: true)
                     }
           
        
        
        
        
      
    } //uploadstart
    
    
    
    
} //Cal_recoardViewController


// 로딩 실행
class Loading_Call {
    static func showLoading() {
        DispatchQueue.main.async {
            // 최상단에 있는 window 객체 획득
            guard let window = UIApplication.shared.windows.last else { return }

            let loadingIndicatorView: UIActivityIndicatorView
            if let existedView = window.subviews.first(where: { $0 is UIActivityIndicatorView } ) as? UIActivityIndicatorView {
                loadingIndicatorView = existedView
            } else {
                loadingIndicatorView = UIActivityIndicatorView(style: .large)
                /// 다른 UI가 눌리지 않도록 indicatorView의 크기를 full로 할당
                loadingIndicatorView.frame = window.frame
                loadingIndicatorView.color = .blue
                window.addSubview(loadingIndicatorView)
            }

            loadingIndicatorView.startAnimating()
        }
    }

    static func hideLoading() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.last else { return }
            window.subviews.filter({ $0 is UIActivityIndicatorView }).forEach { $0.removeFromSuperview() }
        }
    }
}

}
