//
//  btn_myFollow.swift
//  health
//
//  Created by Songjeongpyeong on 2021/10/19.
//

import Foundation
import UIKit

class btn_myFollow: UIButton {
    
    var isActivated : Bool = false
    
    let activatedImage = UIImage(systemName: "heart.fill")?.withTintColor(#colorLiteral(red: 0.2483623028, green: 0.5312670469, blue: 0.9978526235, alpha: 1)).withRenderingMode(.alwaysOriginal)
    let normalImage = UIImage(systemName: "heart")?.withTintColor(#colorLiteral(red: 0.2483623028, green: 0.5312670469, blue: 0.9978526235, alpha: 1)).withRenderingMode(.alwaysOriginal)
    
    override func awakeFromNib() {
        super.awakeFromNib()
       print("여기는 언제 드가")
        configureAction()
    }
    
    func setState(_ newValue: Bool){
        
        // 1. 현재 버튼의 상태 변경
        self.isActivated = newValue
        // 2. 변경된 상태에 따른 이미지 변경
        self.setImage(self.isActivated ? activatedImage : normalImage, for: .normal)
    }
    
    fileprivate func configureAction(){
       
        self.addTarget(self, action: #selector(onBtnClicked(_:)), for: .touchUpInside)
    }
    
    @objc fileprivate func onBtnClicked(_ sender: UIButton){
    
 
        
        
        self.isActivated.toggle()
        // 애니메이션 처리 하기
        
   
        animate()
    }
    
    fileprivate func animate(){ print("MyHeartBtn - animate() called")
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            guard let self = self else { return }
            
            let newImage = self.isActivated ? self.activatedImage : self.normalImage
            //1. 클릭 되었을때 쪼그라 들기 - 스케일 즉 크기 변경 -> 50퍼센트로 1초동안
            self.transform = self.transform.scaledBy(x: 0.5, y: 0.5)
            self.setImage(newImage, for: .normal)
        }, completion: { _ in
            //2. 원래 크기로 돌리기 1초동안
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
            })
        })
        
        
    }
 
}
