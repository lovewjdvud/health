//
//  MypageProfileViewController.swift
//  health
//
//  Created by Songjeongpyeong on 2021/10/20.
//

import UIKit
import YPImagePicker
import Alamofire

class MypageProfileViewController: UIViewController {

    
    @IBOutlet weak var tf_id_Profile: UITextField!
    @IBOutlet weak var tf_name_Profile: UITextField!
    @IBOutlet weak var tf_introduce_Profile: UITextField!
    
    @IBOutlet weak var finishy_btn: UIButton!
    @IBOutlet weak var img_Profile: UIImageView!
    
    var id = ""
    var name = ""
    var intruduce = ""
    var img_name = ""
 
    var filename_img = ""
    var imageData: Data!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setting()
       
        
       
        // 이미지 깍기
        img_Profile.layer.cornerRadius = 13
        img_Profile.clipsToBounds = true
        
//        middleButton.clipsToBounds = true
        img_Profile.layer.cornerRadius = img_Profile.frame.size.width / 2

        // 버튼 깍기
        finishy_btn.layer.cornerRadius = 10 // 버튼 모서리 깍기
       
        //테두리 굵기
        finishy_btn.layer.borderWidth = 2
              //테두리 색상
        finishy_btn.layer.borderColor = CGColor(#colorLiteral(red: 0.2874339819, green: 0.5118607879, blue: 1, alpha: 1))
        
       
    } //viewDidLoad
  

    func setting()  {
        print("\(id) 아이디")
        print("\(name) 이름")
        print("\(intruduce) 소개")
        print("\(img_name) 이름")
        
        tf_id_Profile.text! = id
        tf_name_Profile.text! = name
        tf_introduce_Profile.text! = intruduce
     
       
        
        
        DispatchQueue.global().async {
            guard let url = URL(string: "\(Share.imgurl)\(self.img_name)") else { return }
            print("\(url)")

            guard let data = try? Data(contentsOf: url) else {
                return
            }
            DispatchQueue.main.async {
                self.img_Profile.image = UIImage(data: data)
            }
            
        
    }
    }

         
    
    @IBAction func btn_img_change(_ sender: UIButton) {
        
        
        photo()
    } //btn_img_change
    
   
    @IBAction func finishy_btn(_ sender: UIButton) {
        
        print("ntn")
        
        uploadstart()
    
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
                self.img_Profile.image = photo.image
            }
          
            // 피커 창 닫기
            picker.dismiss(animated: true, completion: nil)
           
            
           
        }
        // 사진 선택 창 보여주가
        present(picker, animated: true, completion: nil)

    } //photo

    
    
    // 사진 업로드 과정
    func uploadstart()  {
        
     
        let date = Date()
        let dateFormatter_cal = DateFormatter()
        dateFormatter_cal.dateFormat = "yyyy-MM-HH:mm"
        dateFormatter_cal.timeZone = TimeZone.current
       
        let currentdate_cal = (dateFormatter_cal.string(from: date))
        
        filename_img = "\(currentdate_cal)\(Share.user_no).jpg"
//
//        var id_change = tf_id_Profile.text!
//        var name_change = tf_name_Profile.text!
//        var introduce_change = tf_introduce_Profile.text!
//        var img_change = filename_img
        
        
        print("\(filename_img) 신찬식 이미지")
        guard  img_Profile.image != nil else {  // 이미지 널값 구분
          print("실패")
            return
        }// 바이트 추출
        imageData = self.img_Profile.image?.jpegData(compressionQuality: 1) // 이미지 jpg데이터로 변형
        
        guard self.imageData != nil else {
            print("널값")
        return
        }
        
        var urlpath =  "\(Share.urlIP)mypage_prfile_change.jsp"// 업로드할 url
        let urlinform = "?user_u_no=\(Share.user_no)&id_change=\(tf_id_Profile.text!)&name_change=\(tf_name_Profile.text!)&introduce_change=\(tf_introduce_Profile.text!)&img_change=\(filename_img)"
        
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
    
    

    
    

}  // MypageProfileViewController
    
}



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






