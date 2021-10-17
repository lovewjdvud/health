////
////  Custom.swift
////  health
////
////  Created by 송정평 on 2021/08/31.
////
//

import Foundation
import UIKit

class Custom: UITabBarController,UITabBarControllerDelegate {

    @IBOutlet weak var tabbar_view: UITabBar!
    required init?(coder: NSCoder) {
        super.init( coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.selectedIndex = 2
        setupMiddleButton()
    }
    func setupMiddleButton()  {
        let middleButton = UIButton(frame: CGRect(x: 320, y:
                                                    6, width: 45, height: 45 )) // 이미지의 사이즈를 관장


        middleButton.setBackgroundImage(UIImage(named: "pencil.png"), for: .normal)
        middleButton.layer.shadowColor = UIColor.black.cgColor
        middleButton.layer.shadowOpacity = 0.1
        middleButton.layer.shadowOffset = CGSize(width: 4, height: 4)

        // 이미지 동그랗게 만들기
        middleButton.clipsToBounds = true
        middleButton.layer.cornerRadius = middleButton.frame.size.width / 2

        self.tabBar.addSubview(middleButton)
        middleButton.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)

        self.view.layoutIfNeeded()
    }

    @objc func menuButtonAction(sendser: UIButton){
        self.selectedIndex = 2
    }

}
