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
