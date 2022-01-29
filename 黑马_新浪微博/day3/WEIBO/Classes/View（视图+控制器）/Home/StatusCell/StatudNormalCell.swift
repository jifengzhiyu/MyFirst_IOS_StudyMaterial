//
//  StatudNormalCell.swift
//  WEIBO
//
//  Created by 翟佳阳 on 2021/12/6.
//

import UIKit
/// 原创微博 Cell
class StatudNormalCell: StatusCell {

    /// 微博视图模型
    override var viewModle: StatusViewModel? {
        didSet {
            
            pictureView.snp.updateConstraints { (make) -> Void in
                
                // 设置配图视图 － 设置视图模型之后，配图视图有能力计算大小
                let offset = (viewModle?.thumbnailUrls?.count)! > 0 ? StatusCellMargin : 0
                make.top.equalTo(contentLabel.snp.bottom).offset(offset)
            }
            
//            pictureView.snp.updateConstraints { make in
//                make.height.equalTo(400)
//            }
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        // 3> 配图视图
                pictureView.snp.makeConstraints { (make) -> Void in
                    make.top.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin)
                    make.left.equalTo(contentLabel.snp.left)
                    make.width.equalTo(contentView.snp.width).offset( -2 * StatusCellMargin)
                    make.height.equalTo(90)
                }
    }

}
