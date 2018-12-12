//
//  ViewController.swift
//  dynamicHeightSample
//
//  Created by EBIZM1 on 2018/12/12.
//  Copyright © 2018 ZhangXiQian. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var wkWebview = WKWebView()
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSubviews()
    }
    
    //MARK:UI
    func createSubviews() {
        wkWebview.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0)
        wkWebview.scrollView.showsHorizontalScrollIndicator = false
        wkWebview.scrollView.showsVerticalScrollIndicator = false
        wkWebview.scrollView.isScrollEnabled = false
        wkWebview.load(URLRequest.init(url: URL.init(string: "https://www.jianshu.com/p/492fafa6df48")!))
        wkWebview.scrollView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let point = change![NSKeyValueChangeKey.init(rawValue: "new")]
        if point is CGSize {
            let height = (point as! CGSize).height
            var frame = self.wkWebview.frame
            frame.size.height = height
            self.wkWebview.frame = frame
            self.mainTableView.tableFooterView = self.wkWebview
        }
    }
    
    
    //MARK:UITableViewDataSource && UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cellID")
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UILabel()
        headView.text = "网页动态高度栗子"
        headView.textColor = UIColor.orange
        headView.textAlignment = NSTextAlignment.center
        headView.backgroundColor = UIColor.yellow
        return headView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }

}

