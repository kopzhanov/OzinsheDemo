//
//  TabBarController.swift
//  OzinsheDemo
//
//  Created by Alikhan Kopzhanov on 21.07.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setTabImages()
    }
    
    func setTabImages(){
        let homeSelectedImage = UIImage(named: "HomeSelected")?.withRenderingMode(.alwaysOriginal)
        
        let searchSelectedImage = UIImage(named: "SearchSelected")?.withRenderingMode(.alwaysOriginal)

        let favoriteSelectedImage = UIImage(named: "FavoriteSelected")?.withRenderingMode(.alwaysOriginal)

        let profileSelectedImage = UIImage(named: "ProfileSelected")?.withRenderingMode(.alwaysOriginal)

        tabBar.items?[0].selectedImage = homeSelectedImage
        tabBar.items?[1].selectedImage = searchSelectedImage
        tabBar.items?[2].selectedImage = favoriteSelectedImage
        tabBar.items?[3].selectedImage = profileSelectedImage
    }
}
