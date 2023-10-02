//
//  CategoryAge.swift
//  OzinsheDemo
//
//  Created by Alikhan Kopzhanov on 02.10.2023.
//

import Foundation
import SwiftyJSON

class CategoryAge{
    public var id = 0
    public var name = ""
    public var link = ""
    
    init(json:JSON) {
        if let temp = json["id"].int{
            self.id = temp
        }
        if let temp = json["name"].string{
            self.name = temp
        }
        if let temp = json["link"].string{
            self.link = temp
        }
    }
}
