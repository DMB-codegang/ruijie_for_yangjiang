#!/bin/sh

#检测输入“logout”命令以后退出登录
if [ "${1}" = "logout" ]; then
  userIndex=`curl -s -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.91 Safari/537.36" -I http://10.20.252.12/eportal/redirectortosuccess.jsp | grep -o 'userIndex=.*'` #Fetch user index for logout request
  logoutResult=`curl -s -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.91 Safari/537.36" -d "${userIndex}" http://10.20.252.12/eportal/InterFace.do?method=logout`
  echo $logoutResult
  exit 0
fi

#检查是否可以联网，可以联网就退出登录
captiveReturnCode=`curl -s -I -m 10 -o /dev/null -s -w %{http_code} http://www.google.cn/generate_204`
if [ "${captiveReturnCode}" = "204" ]; then
  echo "You are already online!"
  echo "您已经正常联网(●'◡'●)"
  exit 0
fi

#如果网络无法连接，就进行ruijie的认证

#获得Ruijie的loginURL
loginPageURL=`curl -s "http://www.google.cn/generate_204" | awk -F \' '{print $2}'`
if [ -z "${loginPageURL}" ]; then
  #有的时候会获取不到，直接拉过来得了（写法存疑）
  loginPageURL="http://10.20.252.12/eportal/index.jsp?wlanuserip=8a642879232d159f7913d3d3aef47d33&wlanacname=16b0c0f4b777150ca8bdcf1c6c309281&ssid=e8665acbe24d304994c8729c8726080b&nasip=3ee885a481183d32df59bb65fa765ed5&mac=0a5ce2a1551e7103bafeb3b7358229f7&t=wireless-v2&url=7b83b64d9f59ab6db231ba35b252f2c1a180d7445f9aa38b79119140b86fb3f48548a1b2660ae802"
fi

#具有阳职特色的service
service="%25E9%2598%25B3%25E8%2581%258C%25E9%2599%25A2"

#对loginURL进行进一步处理
loginURL=`echo ${loginPageURL} | awk -F \? '{print $1}'`
loginURL="${loginURL/index.jsp/InterFace.do?method=login}"

#好像是处理quertString
queryString=`echo ${loginPageURL} | awk -F \? '{print $2}'`
queryString="${queryString//&/%2526}"
queryString="${queryString//=/%253D}"

#发送Ruijie eportal的认证请求
if [ -n "${loginURL}" ]; then
  authResult=`curl -s -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.91 Safari/537.36" -e "${loginPageURL}" -b "EPORTAL_COOKIE_USERNAME=; EPORTAL_COOKIE_PASSWORD=; EPORTAL_COOKIE_SERVER=; EPORTAL_COOKIE_SERVER_NAME=; EPORTAL_AUTO_LAND=; EPORTAL_USER_GROUP=; EPORTAL_COOKIE_OPERATORPWD=;" -d "userId=${1}&password=${2}&service=${service}&queryString=${queryString}&operatorPwd=&operatorUserId=&validcode=&passwordEncrypt=false" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8" -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" "${loginURL}"`
  echo $authResult
fi