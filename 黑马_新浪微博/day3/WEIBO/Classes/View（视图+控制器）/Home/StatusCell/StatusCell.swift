//
//  StatusCell.swift
//  WEIBO
//
//  Created by 翟佳阳 on 2021/12/2.
//

import UIKit
import FFLabel

//间距
let StatusCellMargin: CGFloat = 12
//头像宽度
let StatusCellIconWidth: CGFloat = 35
/// 微博 Cell 代理
protocol StatusCellDelegate: NSObjectProtocol {
    /// 微博 cell 点击 URL
    func statusCellDidClickUrl(url: NSURL)
}

class StatusCell: UITableViewCell {
    /// cell 的代理
    weak var cellDelegate: StatusCellDelegate?

    /// 微博视图模型
    var viewModle: StatusViewModel? {
        didSet {
            topView.viewModle = viewModle
            
            let text = viewModle?.status.text ?? """
ababababbabbabbabbabababababbababababbaabababaababababbabbabbabbabababababbababababbaabababa
ababababbabbabbabbabababababbababababbaabababaababababbabbabbabbabababababbababababbaabababa
ababababbabbabbabbabababababbababababbaabababaababababbabbabbabbabababababbababababbaabababaababababbabbabbabbabababababbababababbaabababaababababbabbabbabbabababababbababababbaabababaababababbabbabbabbabababababbababababbaabababa
"""
            contentLabel.attributedText = EmoticonManager.sharedManager.emoticonText(string: text, font: contentLabel.font)
            // 设置配图视图 － 设置视图模型之后，配图视图有能力计算大小
            pictureView.viewModle = viewModle
            
            pictureView.snp.updateConstraints { (make) -> Void in
                make.height.equalTo(pictureView.bounds.height)
                // 直接设置宽度数值
                make.width.equalTo(pictureView.bounds.width)
                
                // 设置配图视图 － 设置视图模型之后，配图视图有能力计算大小
                let offset = (viewModle?.thumbnailUrls?.count)! > 0 ? StatusCellMargin : 0
//                make.top.equalTo(contentLabel.snp.bottom).offset(offset)
            }
            
//            pictureView.snp.updateConstraints { make in
//                make.height.equalTo(400)
//            }
        }
    }
    
    /// 根据指定的视图模型计算行高
    ///
    /// - parameter vm: 视图模型
    ///
    /// - returns: 返回视图模型对应的行高
     func rowHeight(vm: StatusViewModel) -> CGFloat {
        // 1. 记录视图模型 -> 会调用上面的 didSet 设置内容以及更新`约束`
        viewModle = vm
        
        // 2. 强制更新所有约束 -> 所有控件的frame都会被计算正确
        contentView.layoutIfNeeded()
        
        // 3. 返回底部视图的最大高度
        return bottomView.frame.maxY
    }
    
    
    // MARK: - 构造函数
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        
        selectionStyle = .none
        
        //测试
        contentLabel.text = viewModle?.status.text ??
"""
ababababbabbabbabbabababababbababababbaabababaababababbabbabbabbabababababbababababbaabababa
ssasasassasasasasasasasasssasasassasasasasasasasasssasasassasasasasasasasasssasasassasasasasasasasas
mamamammamamamamam
"""
        
        pictureView.snp.updateConstraints { make in
            make.height.equalTo(Int(arc4random()) % 4 * 90)
                    }
    }

     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    // MARK: - 懒加载控件
    /// 顶部视图
    private lazy var topView: StatusCellTopView = StatusCellTopView()
    /// 微博正文标签
     lazy var contentLabel: FFLabel = FFLabel(title: "微博正文", fontSize: 15, color: .darkGray, screenInset: StatusCellMargin)
    /// 配图视图
     lazy var pictureView: StatusPictureView = StatusPictureView()
    /// 底部视图
     lazy var bottomView: StatusCellBottomView = StatusCellBottomView()

}

// MARK: - 设置界面
extension StatusCell {
    
     @objc func setupUI() {
        // 1. 添加控件
        contentView.addSubview(topView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(pictureView)
        contentView.addSubview(bottomView)
//        bottomView.backgroundColor = .red
        
        //有了     private lazy var contentLabel: UILabel = UILabel(title: "微博正文", fontSize: 15, color: .darkGray, screenInset: StatusCellMargin)
//就不需要下面的话了
//        contentLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 2 * StatusCellMargin
        
        // 2. 自动布局
        // 1> 顶部视图
        topView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            //TODO: - 修改高度
            make.height.equalTo(2 * StatusCellMargin + StatusCellIconWidth)
        }
        
        // 2> 内容标签
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp.left).offset(StatusCellMargin)
            
           
        }
        
        //4>底部
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(pictureView.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            //想要自动计算高度 需要height
            make.height.equalTo(44)
            
            //指定向下的约束
            make.bottom.equalTo(contentView.snp.bottom)
        }
         contentLabel.labelDelegate = self
    }
}

// MARK: - FFLabelDelegate
extension StatusCell: FFLabelDelegate {
    
    func labelDidSelectedLinkText(label: FFLabel, text: String) {
        print(text)
        // 判断 text 是否是 url
        if text.hasPrefix("http://") {
            
            guard let url = NSURL(string: text) else {
                return
            }
            
            cellDelegate?.statusCellDidClickUrl(url: url)
        }
        
    }
}
