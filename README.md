# 阳职校园网认证脚本（openwrt）

心血来潮想在宿舍搞智能家居和服务器，拿出我吃灰已久的树莓派刷了openwrt。  
为了连上校园网，倒腾了好了认证脚本，放出来给校友用 ~~虽然我觉得没校友会用GitHub~~

## 如何使用
0.路由器以client方式接入校园网  
1.下载`ruijie.sh`  
2.将`ruijie.sh`上传到openwrt  
3.执行：
```bash
ruijie.sh 账号 密码
```
4.愉快上网  
然后百度创建计划任务就好了，脚本会自动识别有没有联网
