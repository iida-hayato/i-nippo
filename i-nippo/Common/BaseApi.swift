//
//  Api.swift
//  i-nippo
//
//  Created by hayato.iida on 2016/08/26.
//  Copyright © 2016年 hayato.iida. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol Entity {
  init(json: JSON)
}



struct Api {
  typealias compBlock = ([NipposE]) -> ()
  typealias errBlock = (NSError) -> ()

  static let domain = "http://localhost:3000"

  static func client<T: Entity>(url: String, params: [String: AnyObject]? = nil, success: (([T]) -> ())? = nil, fail: errBlock? = nil) {
    let headers = [
      "Authorization": "Bearer \(Auth.sharedInstance.accessToken()!)"
    ]
    Alamofire.request(.GET, url, parameters: params, headers: headers)
      .responseJSON {
        response in
        switch response.result {
        case .Success(let value):
          if let statusCode = response.response?.statusCode {
            switch statusCode {
            case 401:
              Auth.sharedInstance.logout()
            default:break
            }
          }
          let json = JSON(value)
          print(json)

          success?(json.arrayValue.map {T.init(json: $0)})
        case .Failure(let error):
          print("error")
          print(error.description)
          fail?(error)
          Auth.sharedInstance.logout()
        }
    }
  }
}
