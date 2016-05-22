//
//  ViewController.swift
//  TableViewSample
//
//  Created by 张楚昭 on 16/5/17.
//  Copyright © 2016年 tianxing. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {
    //球队
    var listTeams:NSArray!
    //搜索过滤队名
    var listFilterTeams:NSMutableArray!
    //搜索栏
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //设置搜索栏委托对象为当前视图控制器
        self.searchBar.delegate = self
        //设置搜索范围栏为隐藏
        self.searchBar.showsScopeBar = false
        //重新设置搜索栏大小
        self.searchBar.sizeToFit()
        //获取球队资源文件路径
        let plistPath = NSBundle.mainBundle().pathForResource("team", ofType: "plist")
        //获取属性列表文件中的全部数据
        self.listTeams = NSArray(contentsOfFile: plistPath!)
        //        print(self.listTeams)
        //初次进入查询所有数据
        self.filterContentForSearchText("",scope:-1)
    }
    //自定义过滤结果集方法
    func filterContentForSearchText(searchText:NSString, scope:Int){
        if searchText.length == 0 {
            //查询所有
            self.listFilterTeams = NSMutableArray(array: self.listTeams)
            return
        }
        
        var tempArray:NSArray!
        // 0为中文，1为英文
        if scope == 0 {
            let scopePredicate = NSPredicate(format: "SELF.name contains[c] %@", searchText)
            tempArray = self.listTeams.filteredArrayUsingPredicate(scopePredicate)
            self.listFilterTeams = NSMutableArray(array: tempArray)
        }else if scope == 1{
            let scopePredicate = NSPredicate(format: "SELF.image contains[c] %@", searchText)
            tempArray = self.listTeams.filteredArrayUsingPredicate(scopePredicate)
            self.listFilterTeams = NSMutableArray(array: tempArray)
        }else{
            self.listFilterTeams = NSMutableArray(array: self.listTeams)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //实现UITableViewDataSource 协议方法
    //返回某个节中的行数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.listFilterTeams.count
    }
    //为表视图单元格提供数据
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cellIdentifier = "CellIdentifier"
//        纯代码重用单元格
        var cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)  //.Default .Subtitle .Value1 .Value2 单元格四种样式
        }
//        视图中指定重用单元格
//        let cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        let row = indexPath.row
        let rowDict = self.listFilterTeams[row] as! NSDictionary
//        print(rowDict)
        cell.textLabel?.text = rowDict["name"] as? String
        let imagePath = NSString(format: "%@.png", rowDict["image"] as! String)
        cell.imageView?.image = UIImage(named: imagePath as String)
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator//.Checkmark//.DetailButton//.DetailDisclosureButton 扩展视图四种类型
        return cell
    }
    //实现UISearchBarDelegate协议方法
    //获得焦点时，成为第一响应者，触发显示搜索范围栏
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        self.searchBar.showsScopeBar = true
        self.searchBar.sizeToFit()
        return true
    }
    //响应点击键盘上的搜索按钮事件
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchBar.showsScopeBar = false
        self.searchBar.resignFirstResponder()
        self.searchBar.sizeToFit()
    }
    //响应点击搜索栏上取消按钮事件
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.filterContentForSearchText("", scope: -1)
        self.searchBar.showsScopeBar = false
        self.searchBar.resignFirstResponder()
        self.searchBar.sizeToFit()
    }
    //输入文本内容改变时调用
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterContentForSearchText(searchText, scope: self.searchBar.selectedScopeButtonIndex)
        self.tableView.reloadData()
    }
    //搜索范围选择发生变化时调用
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.filterContentForSearchText(searchBar.text!, scope: selectedScope)
        self.tableView.reloadData()
    }
}

