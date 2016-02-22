//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by Marco Guilmette on 2016-02-21.
//  Copyright © 2016 Marco Guilmette. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

    @IBOutlet weak var musicImage: UIImageView!

    @IBOutlet weak var rank: UILabel!
    
    @IBOutlet weak var musicTitle: UILabel!
    

    var video: Videos? {
        didSet {
            updateCell()
        }
    }
    
    func updateCell() {
        
        musicTitle.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        rank.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
        
        musicTitle.text = video?.vName
        rank.text = String(video!.vRank)
        musicImage.image = UIImage(named: "imageNotAvailable")
        
        if video!.vImageData != nil {
            //Get image from local "cache"
            print("Get data from the array")
            musicImage.image = UIImage(data: video!.vImageData!)
        }
        else
        {
            //Get Image from the web
            print("Get image from the backgrouhnd thread")
            self.getVideoImage(video!, imageView: musicImage)
            
        }
        
        
        
    }
    
    func getVideoImage(video: Videos, imageView : UIImageView){
        
        
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            
            let data  = NSData(contentsOfURL: NSURL(string: video.vImageUrl)!)
            
            var image : UIImage?
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data!)
            }
            
            //Return it back to the Main Queue
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                imageView.image = image
            })
            
        }
        
    }
}
