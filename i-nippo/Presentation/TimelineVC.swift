//
//  TimelineVC.swift
//  i-nippo
//
//  Created by hayato.iida on 2016/08/26.
//  Copyright © 2016年 hayato.iida. All rights reserved.
//

import Foundation
import UIKit
final class TimelineVC: UIViewController, instantiableStoryboard, UITableViewDataSource, UITableViewDelegate {
  @IBOutlet var tableView: UITableView!

  var _data: [NippoEntity]  = []
  var data: [NippoEntity] {
    get {
      return self._data
    }
    set(d) {
      self._data = d
      self.tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.rowHeight = UITableViewAutomaticDimension
    //カスタムセルを指定
    let nib  = UINib(nibName: "TimelineCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier:"Cell")
  }

  override func viewDidAppear(_ animated: Bool) {
    Api.nippos {
      self.data  = $0
    }
  }

  // セルの行数
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }

  // セルのテキストを追加
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TimelineCell
    cell?.title.text  = data[(indexPath as NSIndexPath).row].subject
    cell?.body.text  = data[(indexPath as NSIndexPath).row].body
    return cell!
  }

  // セルがタップされた時
  func tableView(_ table: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(data[(indexPath as NSIndexPath).row])
  }

  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
}
