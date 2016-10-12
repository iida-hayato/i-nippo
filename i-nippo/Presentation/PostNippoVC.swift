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


  @IBAction func sendMessage(_ sender: AnyObject) {
    Api.sendNippo(body: textView.text)
  }
}
