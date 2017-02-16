//
//  ViewController.swift
//  banTang_Demo
//
//  Created by 汪俊 on 2017/1/12.
//  Copyright © 2017年 Codans. All rights reserved.
//

import UIKit
let WIDTH = UIScreen.main.bounds.size.width
let HEIGHT = UIScreen.main.bounds.size.height
let Statics_CELL_WIDTH = WIDTH * 186.4 / 1242
let Statics_CELL_HEIGHT = Statics_CELL_WIDTH * 144.4 / 186.4
let DEFAULT_CENTER_Y = HEIGHT * 740.4 / 2208.0 / 2


class ViewController: UIViewController {
    @IBOutlet weak var navigetionView: UIView!              // 导航条
    @IBOutlet weak var titleBackView: UIView!               // 头部底层View
    @IBOutlet weak var titlewheelBackView: UIView!          // 头部轮播View
    @IBOutlet weak var titleCollectionView: UICollectionView! // 头部标签View
    @IBOutlet weak var mainTableView: UITableView!          // 列表
    @IBOutlet weak var searchImageView: UIImageView!        // 搜索view
    
    @IBOutlet weak var rightButton: UIButton!    // 右侧安妮
    @IBOutlet weak var rightButton2: UIButton!   // 右侧按钮
    
    var imageArray = [UIImage]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setTitleView()
    }
    
    func setTitleView() {
        // 设置导航条初始状态
        navigetionView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.0)
        
        // 设置轮播图
        for i in 1...4 {
            imageArray.append(UIImage(named: "image\(i)")!)
        }
        let myView = WheelImageView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT * 596 / 2208), imageArray: imageArray, frequency: 4)
        self.titlewheelBackView.addSubview(myView)
        
        // 设置标签
        titleCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionViewCell_Flag")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: Statics_CELL_WIDTH, height: Statics_CELL_HEIGHT)
        titleCollectionView.collectionViewLayout = layout
        titleCollectionView.showsHorizontalScrollIndicator = false
        
        mainTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell_Flag")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

/**
 *
 *   UITableView
 *
 */
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell_Flag", for: indexPath) as! TableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HEIGHT * 740.4 / 2208.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT * 740.4 / 2208.0))
        view.backgroundColor = UIColor.clear
        return view
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HEIGHT * 852 / 2001
    }
}

/**
 *
 *   UIScrollView
 *
 */
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 控制处理导航view的透明度
        let point = scrollView.contentOffset.y / (titlewheelBackView.bounds.height - 64.0)
        self.navigetionView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: point)
        
        // 控制头部跟随滑动到导航条高度停止
        if scrollView.contentOffset.y > titlewheelBackView.bounds.height - 64.0 {
            titleBackView.frame.origin.y = -(titlewheelBackView.bounds.height - 64.0)
            // 搜索框滑动出现
            UIView.animate(withDuration: 0.3, animations: {
                self.searchImageView.frame.origin.x = 15
                self.rightButton2.alpha = 1
            })
            return
        }
        // 头部y高出0下滑时不跟随
        if scrollView.contentOffset.y <= 0 {
            titleBackView.frame.origin.y = 0
            return
        }
        // 控制头部跟随滑动
        titleBackView.center.y = DEFAULT_CENTER_Y - scrollView.contentOffset.y
        // 搜索框滑出屏幕
        UIView.animate(withDuration: 0.3, animations: {
            self.searchImageView.frame.origin.x = -340
            self.rightButton2.alpha = 0
        })
    }
}

/**
 *
 *   UICollectionView
 *
 */
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell_Flag", for: indexPath) as! CollectionViewCell
        return cell
    }
}

