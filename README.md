# iOS Search TableView Sample

TableView内容搜索实战示例，基于语言Swift2.2，环境XCode7.3.1

本工程在[简单TableView示例](https://github.com/zhuifengshen/iOSTableViewSample)上增加了对每个单元格的搜索功能，支持实时和中英文搜索，具体运行情况如下：

![iOSSearchTableViewSample](search.gif "运行示例")

### 实现搜索功能要点：
* 实现UISearchBarDelegate协议方法searchBarShouldBeginEditing:响应搜索框获得焦点时，显示中英文搜索；
* 实现UISearchBarDelegate协议方法searchBarButtonClicked:响应点击键盘搜索按钮时，隐藏中英文搜索和键盘；
* 实现UISearchBarDelegate协议方法searchBarCancelButtonClicked:响应点击取消搜索按钮时，隐藏中英文搜索和键盘，同时恢复所有列表项；
* 实现UISearchBarDelegate协议方法searchBar:textDidChange:响应当输入搜索栏文字发生改变时，根据当前文字内容实时过滤列表项；
* 实现UISearchBarDelegate协议方法searchBar:selectedScopeButtonIndexDidChange:响应选择中英文搜索方式切换；

如果喜欢的话，欢迎**Start**一下
