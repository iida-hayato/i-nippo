//
//  TimelineCell.swift
//  i-nippo
//
//  Created by hayato.iida on 2016/09/04.
//  Copyright © 2016年 hayato.iida. All rights reserved.
//

import UIKit

class TimelineCell: UITableViewCell {
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var body: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
      //表示可能最大行数を指定
      body.numberOfLines = 0
      //contentsのサイズに合わせてobujectのサイズを変える
      body.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
