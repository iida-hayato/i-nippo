//
//  Api.swift
//  i-nippo
//
//  Created by hayato.iida on 2016/08/26.
//  Copyright © 2016年 hayato.iida. All rights reserved.
//

import Foundation
import SwiftyJSON

struct NippoEntity: Entity {
  var user_id: Int?
  var reported_for: String?
  var subject: String?
  var body: String?
  var sent_at: String?

  init(json: JSON) {
    user_id = json["user_id"].int
    reported_for = json["reported_for"].string
    subject = json["subject"].string
    body = json["body"].string
    sent_at = json["sent_at"].string
  }
}

extension Api {
  static func nippos(success: compBlock? = nil) {
    let url = domain + "/api/nippos"
    client(url, success:success, fail:nil)
  }
}
