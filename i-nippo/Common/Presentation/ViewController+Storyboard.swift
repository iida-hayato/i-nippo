//
//  ViewController+Storyboard.swift
//  i-nippo
//
//  Created by hayato.iida on 2016/08/27.
//  Copyright © 2016年 hayato.iida. All rights reserved.
//

import UIKit

protocol instantiableStoryboard{
  static var storyboardName:String {get}
  static func initFromStoryboard()->Self
}

extension instantiableStoryboard{
  static var storyboardName:String {
    get{
      return String(Self.self)
    }
  }
  static func initFromStoryboard()->Self{
    let storyboard: UIStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
    let vc =  storyboard.instantiateInitialViewController()
    return vc  as! Self
  }
}