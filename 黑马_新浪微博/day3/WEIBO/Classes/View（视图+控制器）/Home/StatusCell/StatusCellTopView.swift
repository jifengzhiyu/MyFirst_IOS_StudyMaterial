//
//  StatusCellTopView.swift
//  WEIBO
//
//  Created by 翟佳阳 on 2021/12/2.
//

import UIKit
import SDWebImage

 
class StatusCellTopView: UIView {
    
    /// 微博视图模型
    var viewModle: StatusViewModel? {
        didSet {
            // 姓名
            nameLabel.text = viewModle?.status.user?.screen_name
            // 头像
            iconView.setImageWith(viewModle!.userProfileUrl, placeholderImage: viewModle?.userDefaultIconView)
            // 会员图标
            memberIconView.image = viewModle?.userMemberImage
            // 认证图标
            vipIconView.image = viewModle?.userVipImage
            
            // TODO - 后续会讲
            // 时间
//            timeLabel.text = "刚刚" // viewModle?.status.created_at
            timeLabel.text = viewModle?.createAt
            // 来源
            sourceLabel.text = viewModle?.status.source
            //sourceLabel.text = "来自 黑马微博"
        }
    }
    
    // MAKR: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载控件
    /// 头像
    private lazy var iconView: UIImageView = UIImageView(image: (UIImage.init(named: "avatar_default_big")))
    
    /// 姓名
    private lazy var nameLabel: UILabel = UILabel(title: "啊吧狗", fontSize: 14)
    
    /// 会员图标
    private lazy var memberIconView: UIImageView = UIImageView(image: (UIImage.init(named: "common_icon_membership_level1")))
    
    /// 认证图标
         private lazy var vipIconView: UIImageView = UIImageView(image: (UIImage.init(named: "avatar_vip")))
    
    /// 时间标签
    private lazy var timeLabel: UILabel = UILabel(title: "现在", fontSize: 11, color: .orange)
    
    /// 来源标签
    private lazy var sourceLabel: UILabel = UILabel(title: "来源", fontSize: 11)

}


// MARK: - 设置界面
extension StatusCellTopView {
    
    private func setupUI() {
        backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        // 0. 添加分隔视图
        let sepView = UIView()
        sepView.backgroundColor = .lightGray
        addSubview(sepView)
        
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(memberIconView)
        addSubview(vipIconView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        
        // 2. 自动布局
        
        sepView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(StatusCellMargin)
        }
        
        iconView.snp.makeConstraints { make in
            
            make.top.equalTo(sepView.snp.bottom).offset(StatusCellMargin)
            make.left.equalTo(self.snp.left).offset(StatusCellMargin)
            make.height.equalTo(StatusCellIconWidth)
            make.width.equalTo(StatusCellIconWidth)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.top)
            make.left.equalTo(iconView.snp.right).offset(StatusCellMargin)
        }
        memberIconView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.top)
            make.left.equalTo(nameLabel.snp.right).offset(StatusCellMargin )
        }
        vipIconView.snp.makeConstraints { make in
            make.centerX.equalTo(iconView.snp.right)
            make.centerY.equalTo(iconView.snp.bottom)
        }
        timeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(iconView.snp.bottom)
            make.left.equalTo(iconView.snp.right).offset(StatusCellMargin)
        }
        sourceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(timeLabel.snp.bottom)
            make.left.equalTo(timeLabel.snp.right).offset(StatusCellMargin)
        }
    }
}
