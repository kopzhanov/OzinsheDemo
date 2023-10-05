//
//  Profile.swift
//  OzinsheDemo
//
//  Created by Alikhan Kopzhanov on 04.10.2023.
//

import Foundation
import SwiftyJSON

class Profile{
    public var name = ""
    public var email = ""
    public var phoneNumber = ""
    public var birthDate = ""
    
    init(json: JSON) {
        if let temp = json["name"].string{
            self.name = temp
        }
        if let temp = json["user"]["email"].string{
            self.email = temp
        }
        if let temp = json["phoneNumber"].string{
            self.phoneNumber = temp
        }
        if let temp = json["birthDate"].string{
            self.birthDate = temp
        }
    }
}
