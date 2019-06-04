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
    //家庭名称
    @objc dynamic var homeName = ""
    //家庭住址
    @objc dynamic var address = ""
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
    @objc dynamic var led = 0.00
//    //红外感应
    @objc dynamic var redline = 0.00
    //时间
    @objc dynamic var time = ""
    
    @objc dynamic var date = Date()
}

//连接状态
class dataState:Object {
    //
    @objc dynamic var tempState = false
    //
    @objc dynamic var humiState = false
    //
    @objc dynamic var pmState = false
    //
    @objc dynamic var ledState = false
    //
    @objc dynamic var redState = false
    //
    @objc dynamic var lightState = false
    //
    @objc dynamic var fanState = false
    
    @objc dynamic var date = Date()
}

class logs:Object {
    @objc dynamic var type = ""
    @objc dynamic var time = ""
}
