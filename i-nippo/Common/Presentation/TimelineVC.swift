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

  var refleshControl:UIRefreshControl!

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
    self.refleshControl = UIRefreshControl()
    self.refleshControl.attributedTitle = NSAttributedString(string: "引っ張って更新")
    self.refleshControl.addTarget(self, action: #selector(reflesh), forControlEvents: UIControlEvents.ValueChanged)
    self.tableView.addSubview(self.refleshControl)
  }

  func reflesh(){
    Api.nippos {
      self.data  = $0
      self.refleshControl.endRefreshing()
    }
  }

  override func viewDidAppear(animated: Bool) {
    reflesh()
  }

  // セルの行数
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }

  // セルのテキストを追加
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")

    cell.textLabel?.text = data[indexPath.row].body
    return cell
  }

  // セルがタップされた時
  func tableView(table: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    print(data[indexPath.row])
  }
}
