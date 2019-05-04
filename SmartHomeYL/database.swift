import Foundation
import RealmSwift

//用户类
class Users:Object {
    //用户名
    @objc dynamic var name = ""
    //手机号
    @objc dynamic var phone = ""
    //密码
    @objc dynamic var password = ""
}

//收到数据
class getDatas:Object {
    //id
//    @objc dynamic var id = 1
    //温度
    @objc dynamic var temprature = 0.00
    //湿度
    @objc dynamic var humidity = 0.00
//    //pm2.5
    @objc dynamic var pm = 0.00
//    //led灯
//    @objc dynamic var led = false
//    //红外感应
//    @objc dynamic var redline = false
    //时间
    @objc dynamic var time = ""
    
    @objc dynamic var date = Date()
}

//传出数据
class postDatas:Object {
    //id
    @objc dynamic var id = 1
    //传出消息
    @objc dynamic var postmsg = ""
    //时间
    @objc dynamic var date = Date()
}
