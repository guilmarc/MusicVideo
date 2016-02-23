//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Marco Guilmette on 2016-02-22.
//  Copyright © 2016 Marco Guilmette. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MusicVideoDetailVC: UIViewController {

    var videos : Videos!
    
    @IBOutlet weak var vName: UILabel!
    
    @IBOutlet weak var videoImage: UIImageView!
    
    @IBOutlet weak var vGenre: UILabel!
    
    @IBOutlet weak var vPrice: UILabel!
    
    @IBOutlet weak var vRights: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        vName.text = videos.vName
        vPrice.text = videos.vPrice
        vRights.text = videos.vRights
        vGenre.text = videos.vGenre
        
        if let imageData = videos.vImageData {
            videoImage.image = UIImage(data: imageData)
        } else {
            videoImage.image = UIImage(named: "imageNotAvailable")
        
        }
        
        self.title = videos.vArtist
    }
    
    @IBAction func playVideo(sender: UIBarButtonItem) {
        let player = AVPlayer(URL: NSURL(string: videos.vVideoUrl)!)
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        
        self.presentViewController(playerVC, animated: true) { () -> Void in
            playerVC.player?.play()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    

}
