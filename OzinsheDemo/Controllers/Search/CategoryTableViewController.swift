//
//  CategoryTableViewController.swift
//  OzinsheDemo
//
//  Created by Alikhan Kopzhanov on 01.11.2023.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD

class CategoryTableViewController: UITableViewController {
    
    var categoryID = 0
    var categoryName = ""
    
    var movies:[Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = categoryName
        
        let MovieCellnib = UINib(nibName: "MovieCell", bundle: nil)
        tableView.register(MovieCellnib, forCellReuseIdentifier: "MovieCell")
        
        self.title = categoryName
        
        downloadMoviesByCategory()
    }
    
    func downloadMoviesByCategory(){
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = ["Authorization":"Bearer \(Storage.sharedInstance.accessToken)"]
        let parameters = ["categoryId:": categoryID]
        
        AF.request(Urls.MOVIES_BY_CATEGORY_URL, method: .get,parameters: parameters, headers: headers).responseData { response in
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data{
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                if json["content"].exists() {
                    if let array = json["content"].array{
                        for item in array{
                            let movie = Movie(json:item)
                            self.movies.append(movie)
                        }
                        self.tableView.reloadData()
                    }
                } else {
                    SVProgressHUD.showError(withStatus: "Connection Error")
                }
            } else {
                var ErrorString = "Connection Error"
                if let sCode = response.response?.statusCode{
                    ErrorString = ErrorString + " \(sCode)"
                }
                ErrorString = ErrorString + " \(resultString)"
                SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell

        // Configure the cell...
        cell.setData(movie: movies[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieInfoVC = storyboard?.instantiateViewController(withIdentifier: "MovieInfoViewController") as! MovieInfoViewController
        
        movieInfoVC.movie = movies[indexPath.row]
        
        navigationController?.show(movieInfoVC, sender: self)
    }
}
