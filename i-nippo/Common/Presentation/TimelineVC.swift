//
//  TimelineVC.swift
//  i-nippo
//
//  Created by hayato.iida on 2016/08/26.
//  Copyright © 2016年 hayato.iida. All rights reserved.
//

import Foundation
import UIKit
final class TimelineVC: UIViewController ,instantiableStoryboard,UITableViewDataSource,UITableViewDelegate {
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
    tableView.registerNib(nib, forCellReuseIdentifier:"Cell")
  }

  override func viewDidAppear(animated: Bool) {
    Api.nippos {
      self.data  = $0
    }
  }

  // セルの行数
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }

  // セルのテキストを追加
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? TimelineCell
    cell?.title.text  = data[indexPath.row].subject
    cell?.body.text  = data[indexPath.row].body
    return cell!
  }

  // セルがタップされた時
  func tableView(table: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    print(data[indexPath.row])
  }

  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
}
