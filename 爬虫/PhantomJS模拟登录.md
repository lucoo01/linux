
```
var page = require("webpage").create();
var fs = require("fs");
var args = require('system').args;

var output = './screen_login.png';//存储文件路径和名称  

page.onConsoleMessage = function(msg) {
    console.log(msg);
};

page.viewportSize = { width: 1280, height: 800 };//设置长宽  
  
page.open('登录的网址', function (status) {  
	if (status !== 'success') {  
		console.log('Unable to load the address!');  
		phantom.exit();  
	} else {


	setTimeout(function(){


		page.evaluate(function() {
		  // 切换到登录状态
			$(".login-box-header [data-type='pwd']").trigger('click');
			

		});
	}, 1000);

	setTimeout(function(){

		page.evaluate(function() {
		
			$("#account_input").val("用户名");
			$("#password_input").val("密码");
			$("#pwd_confirm").trigger("click");

		});
	}, 1500);
		
	setTimeout(function(){
		page.render(output);
		var file = fs.open("cookie.log", 'w');
        file.write(JSON.stringify(page.cookies));
        file.close();
		phantom.exit();
	},5000);

	}  
});

```
