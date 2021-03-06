//
//  Auth.swift
//  i-nippo
//
//  Created by hayato.iida on 2016/08/26.
//  Copyright © 2016年 hayato.iida. All rights reserved.
//

import Foundation
import OAuthSwift
import SwiftyJSON
import KeychainAccess

class Auth {
  static let sharedInstance = Auth()
  let ACCESS_TOKEN   = "access_token"
  let keychain = KeychainAccess.Keychain(service: "hi.i-nippo")

  let oauthswift: OAuth2Swift

  init() {
    oauthswift = OAuth2Swift(
      consumerKey:    "a3fe053f35b762d680ff826e91c2f0bbbb2fcd36774779c1cd6a7a90c293b226",
      consumerSecret: "91c4bfb0ae72702a91cc4805517c97d4a129785cd08e9f712a77d8c123a1a42f",
      authorizeUrl:   Api.domain + "/oauth/authorize",
      accessTokenUrl: Api.domain + "/oauth/token",
      responseType:   "code"
    )
  }
  func auth() {
    oauthswift.authorizeWithCallbackURL(
      NSURL(string: "oauth-swift://oauth/callback")!,
      scope: "", state:"NIPPO",
      success: { credential, response, parameters in
        // トークンを保存
        try! self.keychain.set(credential.oauth_token, key: self.ACCESS_TOKEN)
        print(credential.oauth_token)
      },
      failure: { error in
        print(error.localizedDescription)
    })
  }

  func accessToken() -> String? {
    return try! keychain.get(ACCESS_TOKEN)
  }

  func loggedIn() -> Bool {
    return self.accessToken() != nil
  }

  func logout() {
    try! keychain.remove(ACCESS_TOKEN)
  }

}
