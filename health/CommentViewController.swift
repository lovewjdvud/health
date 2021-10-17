//
//  CommentViewController.swift
//  health
//
//  Created by Songjeongpyeong on 2021/10/16.
//

import UIKit

class CommentViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var toolbar_comm: UIToolbar!
    @IBOutlet weak var tableView_comm: UITableView!
    @IBOutlet weak var textfielf_comm: UITextField!
 
    
    
    var keyHeight: CGFloat?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
              NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
              NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

    } //viewDidLoad
    
    
    // 키보드 올라 올때 키보드 높이 만큼 뷰 높이를 줄여줌
    
    @objc func keyboardWillShow(_ sender: Notification) {
            let userInfo:NSDictionary = sender.userInfo! as NSDictionary
            let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            keyHeight = keyboardHeight

            self.view.frame.size.height -= keyboardHeight
        }
    

    // 키보드 빠질때 넣을 다시 뷰를 원래 대로
    @objc func keyboardWillHide(_ sender: Notification) {
            
            self.view.frame.size.height += keyHeight!
        }
    
    
    
    // 댓글 입력 버튼
    @IBAction func barbtn_commupload(_ sender: UIBarButtonItem) {
        textfielf_comm.resignFirstResponder() // 원래로 돌아가기
        
    }
    


    
    
} //CommentViewController
