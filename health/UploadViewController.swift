//
//  UploadViewController.swift
//  health
//
//  Created by Songjeongpyeong on 2021/10/08.
//

import UIKit
import YPImagePicker

class UploadViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var img_upload: UIImageView!
    @IBOutlet weak var textView_upload: UITextView!
    @IBOutlet weak var tagtextfield_upload: UITextView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        photo()
        
        
        placeholderSetting()
        // Do any additional setup after loading the view.
        
        
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
        
        let picker = YPImagePicker(configuration: config)
        // 사진 선택시
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
//                print(photo.image) // Final image selected by the user
//                print(photo.originalImage) // original image selected by the user, unfiltered
//                print(photo.modifiedImage) // Transformed image, can be nil
//                print(photo.exifMeta) // Print exif meta data of original image.
//                print("사진 \(photo.url) 사진") // Print exif meta data of original image.
//
                // 프사 이미지 넣기
                self.img_upload.image = photo.image
          
            }
        
            // 피커 창 닫기
            picker.dismiss(animated: true, completion: nil)
        }
        // 사진 선택 창 보여주가
        present(picker, animated: true, completion: nil)
        print("\(img_upload.image)핳하ㅏ하하")
//        let imageData: Data = img_upload.image!.pngData()!
//        let imageStr: String = imageData.base64EncodedString()
//        let urlString: String = "imageStr=" + imageStr
//        print("\(urlString) 유알엘")
        
    } //photo

    
  
} //UploadViewController


extension UploadViewController : YPImagePickerDelegate {

    func imagePickerHasNoItemsInLibrary(_ picker: YPImagePicker) {
        print("\(img_upload.image)핳하ㅏ하하")
    }

    func shouldAddToSelection(indexPath: IndexPath, numSelections: Int) -> Bool {


        return true
    }




}
