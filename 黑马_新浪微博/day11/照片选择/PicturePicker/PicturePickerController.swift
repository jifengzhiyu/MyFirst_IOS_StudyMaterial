//
//  PicturePickerController.swift
//  照片选择
//
//  Created by 翟佳阳 on 2021/12/15.
//

import UIKit

private let PicturePickerCellId = "PicturePickerCellId"
/// 最大选择照片数量
private let PicturePickerMaxCount = 8
/// 照片选择控制器
class PicturePickerController: UICollectionViewController {
    
    /// 配图数组
    lazy var pictures = [UIImage]()
    /// 当前用户选中的照片索引
    private var selectedIndex = 0
    
    // MARK: - 构造函数
    init(){
        super.init(collectionViewLayout: PicturePickerLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor(white: 0.9, alpha: 1.0)

        self.collectionView!.register(PicturePickerCell.self, forCellWithReuseIdentifier: PicturePickerCellId)

    }
    // MARK: - 照片选择器布局
    private class PicturePickerLayout: UICollectionViewFlowLayout {
        
         override func prepare() {
            super.prepare()
            
            // iOS 9.0 之后，尤其是 iPad 支持分屏，不建议过分依赖 UIScreen 作为布局参照！
            // iPhone 6s- 2/iPhone 6s+ 3
            let count: CGFloat = 4
             //scale分辨率
             let margin = UIScreen.main.scale * 4
            let w = (collectionView!.bounds.width - (count + 1) * margin) / count
            
            itemSize = CGSize(width: w, height: w)
             sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: 0, right: margin)
            minimumInteritemSpacing = margin
            minimumLineSpacing = margin
        }
    }

    

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        // 保证末尾有一个加号按钮，如果达到上限，不显示 + 按钮！
        return pictures.count + (pictures.count == PicturePickerMaxCount ? 0 : 1)
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //as! PicturePickerCell 如果会放问到自定义cell的属性才加上
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicturePickerCellId, for: indexPath) as! PicturePickerCell
    
        // Configure the cell
//        cell.backgroundColor = .red
        // 设置图像
        cell.image = (indexPath.item < pictures.count) ? pictures[indexPath.item] : nil
        
        // 设置代理
        cell.pictureDelegate = self
    
        return cell
    }
}

// MARK: - PicturePickerCellDelegate
//如果协议是私有的。在实现协议方法时,函数也是私有的
//函数私有的，运行时就无法找到该函数,就没有办法发送消息!
//@objc
extension PicturePickerController: PicturePickerCellDelegate {
    /*
     fileprivate 其实就是过去的 private。
     其修饰的属性或者方法只能在当前的 Swift 源文件里可以访问。
     即在同一个文件中，所有的 fileprivate 方法属性都是可以访问到的。
     */
    @objc fileprivate func picturePickerCellDidAdd(cell: PicturePickerCell) {
//        print("addpic")
        // 判断是否允许访问相册
        /**
            PhotoLibrary            保存的照片(可以删除) + 同步的照片(不允许删除)
            SavedPhotosAlbum        保存的照片/屏幕截图/拍照
        */
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            print("无法访问照片库")
            return
        }
        
        // 记录当前用户选中的照片索引
        selectedIndex = collectionView?.indexPath(for: cell)?.item ?? 0
        
        // 显示照片选择器
        let picker = UIImagePickerController()
        
        // 设置代理
        picker.delegate = self
//         picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    @objc fileprivate func picturePickerCellDidRemove(cell: PicturePickerCell) {
        print("removepic")
        // 1. 获取照片索引
        let indexPath = collectionView!.indexPath(for: cell)!
        
        // 2. 判断索引是否超出上限
        if indexPath.item >= pictures.count {
            return
        }
        
        // 3. 删除数据
        pictures.remove(at: indexPath.item)
        
        // 4. 动画刷新视图
        collectionView?.deleteItems(at: [indexPath])
    }
}
// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension PicturePickerController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// 照片选择完成
    ///
    /// - parameter picker: 照片选择控制器
    /// - parameter info:   info 字典
    /// - 提示：一旦实现代理方法，必须自己 dismiss
    /// - picker.allowsEditing = true
    /// - 适合用于`头像`选择
    /// - UIImagePickerControllerEditedImage
    /**
        如果使用 cocos2dx 开发一个`空白的模板`游戏，内存占用 70M，iOS UI的空白应用程序，大概 19M
    
        一般应用程序，内存在 100M 左右都是能够接受的！再高就需要注意！
    */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        let scaleImage = image.scaleToWith(width: 600)

        // 将图像添加到数组
        // 判断当前选中的索引是否超出数组上限
        if selectedIndex >= pictures.count {
            pictures.append(scaleImage)
        } else {
            pictures[selectedIndex] = scaleImage
        }

        // 刷新视图
        collectionView?.reloadData()

        // 释放控制器
        dismiss(animated: true, completion: nil)
    }
}

/// PicturePickerCellDelegate 代理
/// 如果协议中包含 optional 的函数，协议需要使用 @objc 修饰
@objc
private protocol PicturePickerCellDelegate: NSObjectProtocol {
    
    /// 添加照片
    @objc optional func picturePickerCellDidAdd(cell: PicturePickerCell)
    
    /// 删除照片
    @objc optional func picturePickerCellDidRemove(cell: PicturePickerCell)
}

/// 照片选择 Cell - private修饰类，内部的一切方法和属性，都是私有的
private class PicturePickerCell: UICollectionViewCell {

    /// 照片选择代理
    weak var pictureDelegate: PicturePickerCellDelegate?
    
    var image: UIImage? {
        didSet {
            addButton.setImage(image ?? UIImage(named: "compose_pic_add"), for: .normal)
            
            // 隐藏删除按钮 image == nil 就是新增按钮
            removeButton.isHidden = (image == nil)
        }
    }
    
    // MARK: - 监听方法
    @objc func addPicture() {
        //picturePickerCellDidAdd? ?使用 避免没有实现代理方法就挂了
        pictureDelegate?.picturePickerCellDidAdd?(cell: self)
        print("add")
    }
    
    @objc func removePicture() {
        pictureDelegate?.picturePickerCellDidRemove?(cell: self)
        print("remove")
    }
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 设置控件
    private func setupUI() {
        // 1. 添加控件
        contentView.addSubview(addButton)
        contentView.addSubview(removeButton)
        
        // 2. 设置布局
        addButton.frame = bounds
        
        removeButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top)
            make.right.equalTo(contentView.snp.right)
        }
        
        // 3. 监听方法
        addButton.addTarget(self, action: #selector(self.addPicture), for: .touchUpInside)
        removeButton.addTarget(self, action: #selector(self.removePicture), for: .touchUpInside)
        
        // 4. 设置填充模式
        addButton.imageView?.contentMode = .scaleAspectFill
    }
    
    // MARK: - 懒加载控件
    /// 添加按钮
    private lazy var addButton: UIButton = UIButton(imageName: "compose_pic_add", backImageName: nil)
    /// 删除按钮
    private lazy var removeButton: UIButton = UIButton(imageName: "compose_photo_close", backImageName: nil)
}
