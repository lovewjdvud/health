//
//  EditDelegate.swift
//  Day07_NavigationControl
//
//  Created by 송정평 on 2021/07/22.
//

// pritocol : 자바의 interface
protocol EditDelegate {
   // func didMessageEditDone(_ controller: EditViewController, message: String)
    func didMessageEditDone3(_ controller: C_FollowTableViewCell, id_protocol: Dictionary<Int, String>,name_protocol: Dictionary<Int, String>,img_protocol: Dictionary<Int, String>)
    // func didImageOnOffDone(_ controller: EditViewController, isOn  : Bool)
}

