//
//  PostNippoVC.swift
//  i-nippo
//
//  Created by hayato.iida on 2016/09/28.
//  Copyright © 2016年 hayato.iida. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
final class PostNippoVC: UIViewController {
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var sendButton: UIButton!
  @IBOutlet weak var reportedForTextView: UITextField!


  @IBAction func sendMessage(_ sender: AnyObject) {
    guard let reportedFor = reportedForTextView.text else {
      //TODO error監視
      print("reportedFor must not nil")
      return
    }
    Api.sendNippo(body: textView.text,reportedFor: reportedFor)
  }
}
