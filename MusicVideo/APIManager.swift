//
//  APIManager.swift
//  MusicVideo
//
//  Created by Marco Guilmette on 2016-02-20.
//  Copyright © 2016 Marco Guilmette. All rights reserved.
//

import Foundation

class APIManager {
    func loadData(urlString: String, completion: [Videos] -> Void) {
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            
                if error != nil {
       
                    print(error!.localizedDescription)
                    
                } else {
                    
                    
                    do {
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionnary, feed = json["feed"] as? JSONDictionnary, entries = feed["entry"] as? JSONArray {
                            
                            var videos = [Videos]()
                            for entry in entries {
                                let entry = Videos(data: entry as! JSONDictionnary)
                                videos.append(entry)
                            }
                            
  
                            print("iTunesAPIManager - total count --> \(videos.count)")
                            
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            //Set the priority of the dispatch
                            dispatch_async(dispatch_get_global_queue(priority, 0), {
                                //Dispatch on the main cue
                                dispatch_async(dispatch_get_main_queue()) {
                                    completion(videos)
                                }
                            })
                        }
                    } catch {
                        
                            print ("error in NSJSONSerialization")
                        
    
                    }
                    
                    
                    print("NSURLSession successful")
                    
                }
            
        }
        task.resume()
    }
    
}
