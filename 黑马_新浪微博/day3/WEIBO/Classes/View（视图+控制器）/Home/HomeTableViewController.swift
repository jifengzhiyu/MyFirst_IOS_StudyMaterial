//
//  HomeTableViewController.swift
//  WEIBO
//
//  Created by 翟佳阳 on 2021/11/23.
//

import UIKit
import SVProgressHUD

/// 原创微博的可重用 ID
let StatusCellNormalId = "StatusCellNormalId"
/// 转发微博的可重用 ID
let StatusCellRetweetedId = "StatusCellRetweetedId"

class HomeTableViewController: VisitorTableViewController {
    
    
    /// 微博数据列表模型
    private lazy var listViewModel = StatusListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        if !UserAccountViewModel.sharedUserAccount.userLogon {
        visitorView?.setUpInfo(imageName: nil, title: "关注一些人，回这里看看有什么惊喜")
            
            return
        }
     prepareTableView()
//     loadData()
        
        // 注册通知 － 如果使用 通知中心的 block 监听，其中的 self 一定要 弱引用！


        NotificationCenter.default.addObserver(forName: NSNotification.Name.init(rawValue: WBStatusSelectedPhotoNotification), object: nil, queue: nil) {  [weak self] (n) in
//            print("接收通知 \(n)")
//            print(self?.view ?? "")
            guard let indexPath = n.userInfo?[WBStatusSelectedPhotoIndexPathKey] as? NSIndexPath else {
                return
            }
            guard let urls = n.userInfo?[WBStatusSelectedPhotoURLsKey] as? [NSURL] else {
                return
            }

            // 判断 cell 是否遵守了展现动画协议！
            guard let cell = n.object as? PhotoBrowserPresentDelegate else {
                return
            }
            print("选择 照片 cell \(cell)")
            
            let vc = PhotoBrowserViewController(urls: urls, indexPath: indexPath)
            
            // 1. 设置modal的类型是自定义类型 Transition(转场)
            vc.modalPresentationStyle = UIModalPresentationStyle.custom
            // 2. 设置动画代理
            vc.transitioningDelegate = self?.photoBrowserAnimator
            // 3. 设置 animator 的代理参数
            self?.photoBrowserAnimator.setDelegateParams(presentDelegate: cell, indexPath: indexPath, dismissDelegate: vc as! PhotoBrowserDismissDelegate)
            // 参数设置所有权交给调用方，一旦调用方失误漏传参数，可能造成不必要的麻烦
            // 会一系列的 ...
//                self?.photoBrowserAnimator.presentDelegate = cell
//                self?.photoBrowserAnimator.indexPath = indexPath
//                self?.photoBrowserAnimator.dismissDelegate = vc
            
            // 3. Modal 展现
            self?.present(vc, animated: true, completion: nil)
        }
    }
    
    deinit {
        // 注销通知
        NotificationCenter.default.removeObserver(self)
    }
    
    
    /// 准备表格
    private func prepareTableView() {
        // 注册可重用 cell
        tableView.register(StatudNormalCell.self, forCellReuseIdentifier: StatusCellNormalId)
        tableView.register(StatusRetweetedCell.self, forCellReuseIdentifier: StatusCellRetweetedId)

        // 取消分割线
        tableView.separatorStyle = .none
        
        //临时行高
//        tableView.rowHeight = 200
        // 自动计算行高 - 需要一个自上而下的自动布局的控件，指定一个向下的约束
        //        // 预估行高 - 需要尽量准确
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = UITableView.automaticDimension
//        tableView.rowHeight = 400
        
        // 下拉刷新控件默认没有 - 高度 60
//        refreshControl = UIRefreshControl()
        refreshControl = WBRefreshControl()

        
        // 添加监听方法
//        refreshControl?.addTarget(self, action: #selector(self.loadData), for: UIControl.Event.valueChanged)
        
        // 测试代码
//        let v = UIView(frame: CGRect(x: 0, y: 0, width: 180, height: 40))
//        v.backgroundColor = UIColor.red
//        refreshControl?.addSubview(v)
        
        // 设置 tintColor
        refreshControl?.tintColor = UIColor.clear

        // 上拉刷新视图
        tableView.tableFooterView = pullupView
      
    }
    
    /// 加载数据
    /// //target @objc 消息机制
    @objc private func loadData() {
        
        refreshControl?.beginRefreshing()
        // 关闭刷新控件
            self.refreshControl?.endRefreshing()
        // 关闭上拉刷新
        self.pullupView.stopAnimating()
        
        listViewModel.loadStatus(isPullup: pullupView.isAnimating) { isSuccessed in
            if !isSuccessed{
                SVProgressHUD.showInfo(withStatus: "加载数据错误，请稍后再试")
                return
            }
            
            // 显示下拉刷新提示
            self.showPulldownTip()
            
            print(self.listViewModel.statusList)
            self.tableView.reloadData()
        }
    }
    
    /// 显示下拉刷新
    private func showPulldownTip() {
        // 如果不是下拉刷新直接返回
        guard let count = listViewModel.pulldownCount else {
            return
        }
        
        print("下拉刷新 \(count)")
        pulldownTipLabel.text = (count == 0) ? "没有新微博" : "刷新到 \(count) 条微博"
        
        let height: CGFloat = 44
        let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: height)
        pulldownTipLabel.frame = rect.offsetBy(dx: 0, dy: -2 * height)
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.pulldownTipLabel.frame = rect.offsetBy(dx: 0, dy: height)
            }) { (_) -> Void in
                UIView.animate(withDuration: 1.0) {
                    self.pulldownTipLabel.frame = rect.offsetBy(dx: 0, dy: -2 * height)
                }
        }
    }
    
    // MARK: - 懒加载控件
    /// 下拉刷新提示标签
    private lazy var pulldownTipLabel: UILabel = {

        let label = UILabel(title: "", fontSize: 18, color: UIColor.white)
        label.backgroundColor = UIColor.orange
        
        // 添加到 navigationBar
        self.navigationController?.navigationBar.insertSubview(label, at: 0)
        
        return label
    }()
    
    /// 上拉刷新提示视图
    private lazy var pullupView: UIActivityIndicatorView = {
       
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.color = UIColor.lightGray
        indicator.startAnimating()
        return indicator
    }()
    /// 照片查看转场动画代理
    private lazy var photoBrowserAnimator: PhotoBrowserAnimator = PhotoBrowserAnimator()

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return listViewModel.statusList.count
        return 5

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 不会调用行高方法
        // tableView.dequeueReusableCellWithIdentifier()
        // 会调用行高方法！
        let cell = tableView.dequeueReusableCell(withIdentifier: StatusCellRetweetedId, for: indexPath) as! StatusCell
                
//        let vm = listViewModel.statusList[indexPath.row]
//        
//        // 2. 获取可重用 cell 会调用行高方法！
//        let cell = tableView.dequeueReusableCell(withIdentifier: vm.cellId, for: indexPath) as! StatusCell
//        
//        // 3. 设置视图模型
//        cell.viewModle = vm
        
        
        // Configure the cell...
//        可选值符给可选值 显示没有optional
//        cell.textLabel?.text = listViewModel.statusList[indexPath.row].status.user?.screen_name
        
//        cell.viewModle = listViewModel.statusList[indexPath.row]
        
        // 4. 判断是否是最后一条微博
        if indexPath.row == listViewModel.statusList.count - 1 && !pullupView.isAnimating {
            // 开始动画
            pullupView.startAnimating()
            
            // 上拉刷新数据
            loadData()
            
            print("上拉刷新数据")
        }
        cell.cellDelegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("选中行 \(indexPath)")
    }
    

    /**
        行高
    
        -- 设置了预估行高
        * 当前显示的行高方法会调用三次（每个版本的Xcode调用次数可能不同）
    
        问题：预估行高如果不同，计算的次数不同！
    
        1. 使用预估行高，计算出预估的 contentSize
        2. 根据预估行高，判断计算次数，顺序计算每一行的行高，更新 contentSize
        3. 如果预估行高过大，超出预估范围，顺序计算后续行高，一直到填满屏幕退出，同时更新 contentSize
        4. 使用预估行高，每个 cell 的显示前需要计算，单个 cell 的效率是低的，从整体效率高！
    
        执行顺序 行数 -> 每个[cell -> 行高]
     //// 会调用行高方法！
     let cell = tableView.dequeueReusableCell(withIdentifier: StatusCellNormalId, for: indexPath) as! StatusCell
    
        预估行高：尽量靠近！
    
        -- 没设置了预估行高
        * 1. 计算所有行的高度
        * 2. 再计算显示行的高度
    
        执行顺序 行数 -> 行高 -> cell
    
        问题：为什么要调用所有行高方法？UITableView 继承自 UIScrollView
        表格视图滚动非常流畅 -> 需要提前计算出 contentSize
    
        苹果官方文档有指出，如果行高是固定值，就不要实现行高代理方法！
        
        实际开发中，行高一定要缓存！
    */
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        //视图模型
//        return listViewModel.statusList[indexPath.row].rowHeight
//    }

}

// MARK: - StatusCellDelegate
extension HomeTableViewController: StatusCellDelegate {
    
    func statusCellDidClickUrl(url: NSURL) {

        // 建立 webView 控制器
        let vc = HomeWebViewController(url: url)
        vc.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
