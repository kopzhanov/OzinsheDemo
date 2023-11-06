//
//  Urls.swift
//  OzinsheDemo
//
//  Created by Alikhan Kopzhanov on 02.10.2023.
//

import Foundation

class Urls {
    static let BASE_URL = "http://api.ozinshe.com/core/V1/"
    
    static let SIGNIN_URL = "http://api.ozinshe.com/auth/V1/signin"
    static let SIGNUP_URL = "http://api.ozinshe.com/auth/V1/signup"
    static let FAVORITE_URL = BASE_URL + "favorite/"
    static let PROFILE_URL = BASE_URL + "user/profile"
    static let CATEFORIES_URL = BASE_URL + "categories"
    static let MOVIES_BY_CATEGORY_URL = BASE_URL + "movies/page"
    static let SEARCH_MOVIES_URL = BASE_URL + "movies/search"
}
