//
//  APIManager.swift
//  MusicVideo
//
//  Created by Marco Guilmette on 2016-02-20.
//  Copyright © 2016 Marco Guilmette. All rights reserved.
//

import Foundation

class APIManager {
    func loadData(urlString: String, completion: (result:String) -> Void) {
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            
            
                if error != nil {
                    dispatch_async(dispatch_get_main_queue())  {
                        completion (result: (error!.localizedDescription))
                    }
                } else {
                    
                    
                    do {
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String: AnyObject] {
                            
                            print(json)
                            
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            //Set the priority of the dispatch
                            dispatch_async(dispatch_get_global_queue(priority, 0), {
                                //Dispatch on the main cue
                                dispatch_async(dispatch_get_main_queue()) {
                                    completion(result: "JSONSerialization Successful")
                                }
                            })
                        }
                    } catch {
                        dispatch_async(dispatch_get_main_queue())  {
                            completion (result: ("error in NSJSONSerialization"))
                        }
    
                    }
                    
                    
                    completion(result: "NSURLSession successful")
                    
                }
            
        }
        task.resume()
    }
    
}
