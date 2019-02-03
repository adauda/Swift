import Foundation
import UIKit

class FormModel {
    
    var names = [String]()
    
    init() {}
    
    func addName(title: String){
            names.append(title)
            names.sort()
    }
}


struct ValidateField : ViewModel {
    
    var brokenRules: [BrokenRule] = [BrokenRule]()
    
    var password :String = ""
    var phone :String = ""
    var email :String = ""
    var name :String = ""
    
    var nameError :String = ""
    var phoneError :String = ""
    var emailError :String = ""
    var psswdError :String = ""
    
    var isValid: Bool {
        mutating get {
        self.brokenRules = [BrokenRule]()
        self.validate()
        return self.brokenRules.count == 0 ? true : false
     }
}
    
}


extension ValidateField {
    mutating private func validate() {
        
        var phoneNum: String = ""
        
        let num = Int(phone)
        if num != nil { phoneNum = phone }
        else{ phoneNum = "1" }
        
        
        if (password.count) < 7 {
            self.brokenRules.append(BrokenRule(propertyName: "password", message: "short password" ))
            psswdError = "Wrong Password!"
        }
        
        if (phoneNum.count) < 10 {
            self.brokenRules.append(BrokenRule(propertyName: "phone", message: "short phone number" ))
            phoneError = "Wrong Phone!"
        }
        
        if (email.count) < 3 {
            self.brokenRules.append(BrokenRule(propertyName: "phone", message: "short email" ))
            emailError = "Wrong Email!"
        }
        
        if (name.count) < 3 {
            self.brokenRules.append(BrokenRule(propertyName: "phone", message: "short name" ))
            nameError = "Wrong Name!"
        }
        
    }
}



struct BrokenRule {
    var propertyName :String
    var message :String
}

protocol ViewModel {
    var brokenRules :[BrokenRule] { get set }
    var isValid :Bool { mutating get }
}
