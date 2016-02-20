//
//  ViewController.swift
//  MusicVideo
//
//  Created by Marco Guilmette on 2016-02-20.
//  Copyright © 2016 Marco Guilmette. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/ca/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    
    }

    func didLoadData(result: String)  {
        
        let alert = UIAlertController(title: result, message: nil, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
            //do something
        }
        
        alert.addAction(okAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }


}

