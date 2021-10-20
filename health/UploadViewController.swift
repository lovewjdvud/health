//
//  UploadViewController.swift
//  health
//
//  Created by Songjeongpyeong on 2021/10/08.
//

import UIKit
import YPImagePicker
import Alamofire


class UploadViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var img_upload: UIImageView!
    @IBOutlet weak var textView_upload: UITextView!
    @IBOutlet weak var btn_upload2: UIButton!
    
   
    var imageData: Data!
    
    var currentDate = ""
    var up_g_no: Int!
    
    var textView_write = ""
    
    var filename_img = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        photo() // 갤러리 불러오기
        
        btn_upload2.layer.cornerRadius = 30 // 버튼 모서리 깍기
        
                
        guard up_g_no != nil || currentDate == "" else {
            print("up_g_no, currentDate 둘중에 하나 널값")
            return
        }
        
        print("넘버 \(up_g_no!) 현재날짜 \(currentDate) 윤희지")
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool){
    
       
        
        placeholderSetting() // 히든 텍스트
    // 텍스트뷰 테두리 설정
      //  self.textView_upload.layer.borderWidth = 1.0
        self.textView_upload.layer.borderColor = UIColor.black.cgColor
        self.textView_upload.layer.cornerRadius = 10

      
    }
    
    
    
    @IBAction func btn_upload(_ sender: UIButton) {
        
        self.uploadstart() // 업로드 시작
        
    }
    
    func placeholderSetting() {
        textView_upload.delegate = self // txtvReview가 유저가 선언한 outlet
        textView_upload.text = "문구를 입력해주세요"
        textView_upload.textColor = UIColor.lightGray
       
    }
        // TextView Place Holder
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView_upload.textColor == UIColor.lightGray {
                textView_upload.text = nil
                textView_upload.textColor = UIColor.black
            }
            
        }
        // TextView Place Holder
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView_upload.text.isEmpty {
                textView_upload.text = "문구를 입력해주세요."
                textView_upload.textColor = UIColor.lightGray
                
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
                self.img_upload.image = photo.image
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
          
          let currentDate_ = (dateFormatter_cal.string(from: date))
           
        filename_img = "\(currentDate_)\(Share.user_no).jpg"
        textView_write = textView_upload.text! // 텍스트뷰에 쓴글 가져오기
        print("\(textView_write) 윤희지 텍스트")
        guard  img_upload.image != nil else {  // 이미지 널값 구분
          print("실패")
            
            
            return
        }// 바이트 추출
        imageData = self.img_upload.image?.jpegData(compressionQuality: 1) // 이미지 jpg데이터로 변형
        
        guard self.imageData != nil else {
            print("널값")
        return
        }
        
        let urlpath =  "\(Share.urlIP)Uploadimg.jsp?up_g_no=\(up_g_no!)&up_u_no=\(Share.user_no)&currentDate=\(currentDate)&filename_img=\(filename_img)&textView_write=\(textView_write)"// 업로드할 url
        let url = urlpath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        print("\(urlpath) 윤희지")
        
        
        
        // 본격 업로드 시작
        AF.upload(multipartFormData: { multipartFormData in
        
            multipartFormData.append(self.imageData, withName:"Name", fileName: "\(self.filename_img)", mimeType: "image/jpg")
            
        }, to: URL(string: url)!)
        .responseJSON { response in
            print("\(response) ")
            self.navigationController?.popViewController(animated: true) // 화면 보내는 친구
        }
        
        
        
      
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

         self.view.endEditing(true)

   }

    
  
} //UploadViewController


extension UploadViewController : YPImagePickerDelegate {

    func imagePickerHasNoItemsInLibrary(_ picker: YPImagePicker) {
       // print("\(img_upload.image)핳하ㅏ하하")
        print("8")
    }

    func shouldAddToSelection(indexPath: IndexPath, numSelections: Int) -> Bool {


        return true
    }




}
