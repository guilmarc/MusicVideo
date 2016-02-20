//
//  ViewController.swift
//  MusicVideo
//
//  Created by Marco Guilmette on 2016-02-20.
//  Copyright © 2016 Marco Guilmette. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var videos = [Videos]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/ca/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    
    }

    func didLoadData(videos: [Videos])  {
    
        print(reachabilityStatus)
        
        self.videos = videos
        
        for (index, item) in videos.enumerate() {
            print ("\(index) name : \(item.vName)")
        }

        
    }
    
 


}

