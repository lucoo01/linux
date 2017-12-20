# phantomJs页面操作
从1.6版本开始，你可以使用page.includeJs加载jquery到页面中
```
var page = require("webpage").create();
page.open("http://www.sample.com",function(){
　　　　引用jquery，执行回调函数
    page.includeJs("http://code.jquery.com/jquery-2.2.4.min.js",function(){
　　　　　　　　// evaluate执行JS
        page.evaluate(function(){
            $("button").click();
        })
　　　　　　　　退出phantomJs，必须写在includeJs里面，否则可能jquery没加载完成，便结束了phantom
        phantom.exit();
    })
})
```　

3、如果我们现在有一个webpage实例，我们能做些什么呢？

属性：
```
    page.canGoForward --> boolean
window.history.forward是否是一个有效的操作
    page.canGoBack --> boolean  
window.history.back 是否是一个有效的操作
    page.clipRect --> boolean
可以使用以下方式设置成一个对象{top: 0, left: 0, width: 1024, height: 768},它指定将会拍摄屏幕截图的哪部分。
    page.content --> string
整个页面的HTML内容
    page.cookies -->object
当前页面的cookies
    page.customHeaders -->object
TODO
    page.event -->object
包含键的修改和TODO
    page.libraryPath -->string
当前库的路径，通常指被执行脚本的路径
    page.loading -->boolean
页面是否正在加载
    page.loadingProgress -->number
页面加载进度，100意味着页面加载完成
    page.navigationLocked -->boolean
TODO
    page.offlineStoragePath -->string
下线数据或sqlite3数据在本地存储的位置
    page.offlineStorageQuota -->number
可离线存储的配额
    page.paperSize -->object
类似clipRect,但采用实际纸张尺寸，例如A4.
    page.scrollPosition -->object
用以下形式表示的当前滚动位置
{left:0
 top:0
 }
    page.settings -->object
useragent串的设置
    page.title -->string
当前页面的TITLE
    page.url -->string
当前页面的URL
    page.viewportSize -->object
用以下形式表示的浏览器大小{width:1024,height:768}
    page.windowName -->string
由WM分配的浏览器窗口的名字
    page.zoomFactor -->number
缩放系数，默认为1.
```        
函数
```
page.childFramesCount
page.childFramesName
page.close
page.currentFrameName
page.deleteLater
page.destroyed
page.evaluate
page.initialized
page.injectJs
page.javaScriptAlertSent
page.javaScriptConsoleMessageSent
page.loadFinished
page.loadStarted
page.openUrl
page.release
page.render
page.resourceError
page.resourceReceived
page.resourceRequested
page.uploadFile
page.sendEvent
page.setContent
page.switchToChildFrame
page.switchToMainFrame
page.switchToParentFrame
page.addCookie
page.deleteCookie
page.clearCookies
page.click()
page.refresh()
``` 

事件

```
onInitialized
onLoadStarted
onLoadFinished
onUrlChanged
onNavigationRequested
onRepaintRequested
onResourceRequested
onResourceReceived
onResourceError
onResourceTimeout
onAlert
onConsoleMessage
onClosing
```　

