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
        musicTitle.text = video?.vName
        rank.text = String(video!.vRank)
        musicImage.image = UIImage(named: "imageNotAvailable")
        
    }
}
