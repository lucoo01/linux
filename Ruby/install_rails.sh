
gem install rails

rails --version

cd /home/wwwroot

rails new railsdemo

#如果报错  An error occurred while installing sqlite3 (1.3.13), and Bundler cannot continue.
# Make sure that `gem install sqlite3 -v '1.3.13'` succeeds before bundling.

# yum install sqlite-devel

cd railsdemo

bin/rails server
