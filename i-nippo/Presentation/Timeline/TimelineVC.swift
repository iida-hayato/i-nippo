//
//  TimelineVC.swift
//  i-nippo
//
//  Created by hayato.iida on 2016/08/26.
//  Copyright © 2016年 hayato.iida. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class TimelineVC: UIViewController, instantiableStoryboard, UITableViewDataSource, UITableViewDelegate {
  @IBOutlet var tableView: UITableView!
  private let bag = DisposeBag.init()

  enum Mode: Int {
    case Small = 0
    case Large = 1
  }

  var viewMode = Variable<Mode>.init(.Small)

  var _data: [NippoEntity] = []
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
    super.viewDidLoad()

    self.viewMode.asObservable()
    .subscribe(onNext: {
      (mode) in

      switch mode {
      case .Small:
        self.tableView.rowHeight = 44
      case .Large:
        self.tableView.rowHeight = UITableViewAutomaticDimension
      }

      self.tableView.reloadSections(IndexSet.init(integer: 0), with: .none)

    }).addDisposableTo(bag)

    tableView.rx.itemSelected.asDriver().drive(onNext: { [weak self] (index) in
      self?.viewMode.value = Mode(rawValue: ((self?.viewMode.value.rawValue)! + 1) % 2)!
      }).addDisposableTo(bag)



    self.tableView.dataSource = self
    self.tableView.delegate = self
    //カスタムセルを指定
    let nib = UINib(nibName: "TimelineCell", bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: "Cell")
  }

  override func viewDidAppear(_ animated: Bool) {
    Api.nippos {
      self.data = $0
    }
  }

  // セルの行数
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }

  // セルのテキストを追加
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TimelineCell
    cell?.title.text = data[(indexPath as NSIndexPath).row].subject
    cell?.body.text = data[(indexPath as NSIndexPath).row].body
    return cell!
  }

  // セルがタップされた時
  func tableView(_ table: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.viewMode.value = Mode(rawValue: ((self.viewMode.value.rawValue) + 1) % 2)!
    print(data[(indexPath as NSIndexPath).row])
  }

  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
}
