//
//  WelcomeVC.swift
//  i-nippo
//
//  Created by hayato.iida on 2016/08/26.
//  Copyright © 2016年 hayato.iida. All rights reserved.
//

import UIKit
import SwiftyJSON
import OAuthSwift
import KeychainAccess

final class WelcomeVC: UIViewController {

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if Auth.sharedInstance.loggedIn() {
      // ログイン済
      let nextView                 = RootTabVC.initFromStoryboard()
      self.present(nextView, animated: true, completion: nil)

    } else {
      // contextとして自身（UIViewController)を指定する
//      Auth.sharedInstance.oauth2!.authConfig.authorizeContext = self
      // ログイン画面を出す
//      Auth.sharedInstance.oauth2!.authorize()
      Auth.sharedInstance.oauthswift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: Auth.sharedInstance.oauthswift)
      Auth.sharedInstance.auth()
    }
  }
}
