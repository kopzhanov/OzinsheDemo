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
    static let CATEGORIES_URL = BASE_URL + "categories"
    static let MOVIES_BY_CATEGORY_URL = BASE_URL + "movies/page"
    static let SEARCH_MOVIES_URL = BASE_URL + "movies/search"
    static let MAIN_MOVIES_URL = BASE_URL + "movies/main"
    static let MAIN_BANNERS_URL = BASE_URL + "movies_main"
    static let USER_HISTORY_URL = BASE_URL + "history/userHistory"
    static let GENRES_URL = BASE_URL + "genres"
    static let CATEGORY_AGES_URL = BASE_URL + "category-ages"
    static let SIMILAR_URL = BASE_URL + "movies/similar/"
    static let SEASONS_URL = BASE_URL + "seasons/"
    static let CHANGE_PASSWORD_URL = BASE_URL + "user/profile/changePassword"
}
