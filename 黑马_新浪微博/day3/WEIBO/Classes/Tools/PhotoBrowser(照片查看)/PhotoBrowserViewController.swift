//
//  PhotoBrowserViewController.swift
//  WEIBO
//
//  Created by 翟佳阳 on 2021/12/16.
//

import UIKit
import SVProgressHUD
/// 可重用 Cell 标示符号
private let PhotoBrowserViewCellId = "PhotoBrowserViewCellId"

/// 照片浏览器
class PhotoBrowserViewController: UIViewController {
    /// 照片 URL 数组
    private var urls: [NSURL]
    /// 当前选中的照片索引
    private var currentIndexPath: NSIndexPath
    
    // MARK: - 监听方法
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
    
    /// 保存照片
    @objc private func save() {
//        print("保存照片")
        // 1. 拿到图片
        let cell = collectionView.visibleCells[0] as! PhotoBrowserCell
        // imageView 中很可能会因为网络问题没有图片 -> 下载需要提示
        guard let image = cell.imageView.image else {
            return
        }
        
        // 2. 保存图片
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    //  - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
    @objc private func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject?) {
        
        let message = (error == nil) ? "保存成功" : "保存失败"
        
        SVProgressHUD.showInfo(withStatus: message)
    }
    
    // MARK: - 构造函数 属性都可以是必选，不用在后续考虑解包的问题
    init(urls: [NSURL], indexPath: NSIndexPath) {
        self.urls = urls
        self.currentIndexPath = indexPath
        
        // 调用父类方法
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        // 1. 设置根视图
        var rect = UIScreen.main.bounds
        rect.size.width += 20
        
        view = UIView(frame: rect)
        
        // 2. 设置界面
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        print(urls)
//        print(currentIndexPath)
        // 让 collectionView 滚动到指定位置
        collectionView.scrollToItem(at: currentIndexPath as IndexPath, at: .centeredHorizontally, animated: false)
    }
    
    // MARK: - 懒加载控件
    lazy var collectionView: UICollectionView = UICollectionView(frame:CGRect.zero, collectionViewLayout: PhotoBrowserViewLayout())
    /// 关闭按钮
    private lazy var closeButton: UIButton = UIButton(title: "关闭", fontSize: 14, color: .white, imageName: nil, backColor: .darkGray)
    
    /// 保存按钮
    private lazy var saveButton: UIButton = UIButton(title: "保存", fontSize: 14, color: .white, imageName: nil, backColor: .darkGray)

    // MARK: - 自定义流水布局
    private class PhotoBrowserViewLayout: UICollectionViewFlowLayout {
        
         override func prepare() {
            super.prepare()
            
            itemSize = collectionView!.bounds.size
            minimumInteritemSpacing = 0
            minimumLineSpacing = 0
            scrollDirection = .horizontal
            
            collectionView?.isPagingEnabled = true
            collectionView?.bounces = false
            
            collectionView?.showsHorizontalScrollIndicator = false
        }
    }
}


// MARK: - 设置 UI
private extension PhotoBrowserViewController {
    
    private func setupUI() {
        // 1. 添加控件
        view.addSubview(collectionView)
        view.addSubview(closeButton)
        view.addSubview(saveButton)
        
        // 2. 设置布局
        collectionView.frame = view.bounds
        
        closeButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp.bottom).offset(-8)
            make.left.equalTo(view.snp.left).offset(8)
            make.size.equalTo(CGSize(width: 100, height: 36))
        }
        saveButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp.bottom).offset(-8)
            //自定义转场和根视图一样大
            make.right.equalTo(view.snp.right).offset(-28)
            make.size.equalTo(CGSize(width: 100, height: 36))
        }
        // 3. 监听方法
        closeButton.addTarget(self, action: #selector(self.close), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(self.save), for: .touchUpInside)
        
        // 4. 准备控件
        prepareCollectionView()
    }
    /// 准备 collectionView
    private func prepareCollectionView() {
        // 1. 注册可重用 cell
        collectionView.register(PhotoBrowserCell.self, forCellWithReuseIdentifier: PhotoBrowserViewCellId)
        
        // 2. 设置数据源
        collectionView.dataSource = self
    }
}
// MARK: - UICollectionViewDataSource
extension PhotoBrowserViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoBrowserViewCellId, for: indexPath) as! PhotoBrowserCell
        
//        cell.backgroundColor = UIColor.randomColor()
        cell.backgroundColor = UIColor.black
        cell.imageURL = urls[indexPath.item]
        // 设置代理
        cell.photoDelegate = self
         
        return cell
    }
}

// MARK: - PhotoBrowserCellDelegate
extension PhotoBrowserViewController: PhotoBrowserCellDelegate {
    func photoBrowserCellDidZoom(scale: CGFloat) {
        let isHidden = (scale < 1)
        hideControls(isHidden: isHidden)
        
        if isHidden {
            // 1. 根据 scale 修改根视图的透明度 & 缩放比例
            view.alpha = scale
            view.transform = CGAffineTransform(scaleX: scale, y: scale)
        } else {
            view.alpha = 1.0
            view.transform = CGAffineTransform.identity
        }
    }
    
    /// 隐藏或者显示控件
    private func hideControls(isHidden: Bool) {
        closeButton.isHidden = isHidden
        saveButton.isHidden = isHidden
        
        collectionView.backgroundColor = isHidden ? UIColor.clear : UIColor.black
    }
    
    
    func photoBrowserCellDidTapImage() {
        close()
    }
}

// MARK: - 解除转场动画协议
extension PhotoBrowserViewController: PhotoBrowserDismissDelegate {
    
    func imageViewForDismiss() -> UIImageView {
        let iv = UIImageView()
        
        // 设置填充模式
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        // 设置图像 - 直接从当前显示的 cell 中获取
        let cell = collectionView.visibleCells[0] as! PhotoBrowserCell
        iv.image = cell.imageView.image
        
        // 设置位置 - 坐标转换(由父视图进行转换)
        iv.frame = cell.scrollView.convert(cell.imageView.frame, to: UIApplication.shared.keyWindow!)
        
        // 测试代码
        // UIApplication.sharedApplication().keyWindow?.addSubview(iv)
        
        return iv
    }
    
    func indexPathForDismiss() -> NSIndexPath {
        return collectionView.indexPathsForVisibleItems[0] as NSIndexPath
    }
}







