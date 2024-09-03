//
//  MoviePlayerViewController.swift
//  OzinsheDemo
//
//  Created by Alikhan Kopzhanov on 17.12.2023.
//

import UIKit
import YouTubePlayer

class MoviePlayerViewController: UIViewController {
    @IBOutlet weak var player: YouTubePlayerView!
    
    var video_link = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        player.loadVideoID(video_link)
    }
}
