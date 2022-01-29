//
//  StatusRetweetedCellTableViewCell.swift
//  WEIBO
//
//  Created by 翟佳阳 on 2021/12/6.
//

import UIKit
import FFLabel
/// 转发微博的 Cell
class StatusRetweetedCell: StatusCell {
    
    /// 微博视图模型
    /// 如果继承父类的属性
    /// 1. 需要 override
    /// 2. 不需要 super
    /// 3. 先执行父类的 didSet，再执行子类的 didSet -> 只关心 子类相关设置就够了！
    override var viewModle: StatusViewModel? {
        didSet {
            // 转发微博的文字
            let text = viewModle?.retweetedText ?? ""
            retweetedLabel.attributedText = EmoticonManager.sharedManager.emoticonText(string: text, font: retweetedLabel.font)
            
            pictureView.snp.updateConstraints { (make) -> Void in
                
                // 根据配图数量，决定配图视图的顶部间距
                let offset = (viewModle?.thumbnailUrls?.count)! > 0 ? StatusCellMargin : 0
                make.top.equalTo(retweetedLabel.snp.bottom).offset(offset)
            }
        }
    }
    
    // MARK: - 懒加载控件
    /// 背景按钮
    private lazy var backButton: UIButton = {
       
        let button = UIButton()
        
        button.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        return button
    }()
    
    /// 转发标签
    private lazy var retweetedLabel: FFLabel = FFLabel(
        title: "转发微博转发微博转发微博转发微博转发微博转发微博转发微博转发微博转发微博转发微博\n http://www.baidu.com",
        fontSize: 14,
        color: UIColor.darkGray,
        screenInset: StatusCellMargin)

    

}

// MARK: - 设置界面
extension StatusRetweetedCell {
    
    override func setupUI() {
        super.setupUI()
        
        // 1. 添加控件
        contentView.insertSubview(backButton, belowSubview: pictureView)
        contentView.insertSubview(retweetedLabel, aboveSubview: backButton)
        
        // 2. 自动布局
        // 1> 背景按钮
        backButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentLabel.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        // 2> 转发标签
        retweetedLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(backButton.snp.top).offset(StatusCellMargin)
            make.left.equalTo(backButton.snp.left).offset(StatusCellMargin)
        }
        // 3> 配图视图
        pictureView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(retweetedLabel.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(retweetedLabel.snp.left)
            make.width.equalTo(300)
            make.height.equalTo(90)
        }
        retweetedLabel.labelDelegate = self
    }
}

