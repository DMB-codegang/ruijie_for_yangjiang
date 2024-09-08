# 阳职校园网认证脚本（openwrt）

心血来潮想在宿舍搞智能家居和服务器，想让openwrt实现校园网自动认证

于是倒腾了一下认证脚本，放出来给校友用 ~~虽然我觉得没校友会用GitHub~~

## 如何使用？

1. openwrt接入校园网

2. 在openwrt上安装`Luci-app-nettask`，这是一个用于LuCI 界面上编写和运行自定义 Shell 脚本的工具

[点此跳转GitHub - lucikap/luci-app-nettask](https://github.com/lucikap/luci-app-nettask)

3. 安装完成以后进入配置页面，将本项目的ruijie.sh的内容输入到断网时执行

4. 将第3、4行的`<你的账号>`和`<账号密码>`修改为你的账号密码，账号一般是你的手机号

5. 启用脚本并保存应用
