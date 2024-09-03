//
//  FavoriteTableViewController.swift
//  OzinsheDemo
//
//  Created by Alikhan Kopzhanov on 21.07.2023.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class FavoriteTableViewController: UITableViewController {
    
    var arrayFavorite: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let MovieCellnib = UINib(nibName: "MovieCell", bundle: nil)
        tableView.register(MovieCellnib, forCellReuseIdentifier: "MovieCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        downloadFavorites()
    }
    
    func downloadFavorites(){
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = ["Authorization":"Bearer \(Storage.sharedInstance.accessToken)"]
        
        AF.request(Urls.FAVORITE_URL, method: .get, headers: headers).responseData { response in
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data{
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                
                if let array = json.array {
                    self.arrayFavorite.removeAll()
                    for item in array{
                        let movie = Movie(json:item)
                        self.arrayFavorite.append(movie)
                    }
                    self.tableView.reloadData()
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
        return arrayFavorite.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell

        // Configure the cell...
        cell.setData(movie: arrayFavorite[indexPath.row])
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieInfoVC = storyboard?.instantiateViewController(withIdentifier: "MovieInfoViewController") as! MovieInfoViewController
        
        movieInfoVC.movie = arrayFavorite[indexPath.row]
        
        navigationController?.show(movieInfoVC, sender: self)
    }
}
