//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Marco Guilmette on 2016-02-20.
//  Copyright © 2016 Marco Guilmette. All rights reserved.
//

import Foundation

class Videos {
    
    private var _vName:String
    private var _vImageUrl:String
    private var _vVideoUrl:String
    
    
    var nNameL: String {
        return _vName
    }
    
    var vImageURL: String{
        return _vImageUrl
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    init(data: JSONDictionnary) {
        if let name = data["im:name"] as? JSONDictionnary, vName = name["label"] as? String {
            self._vName = vName
        } else {
            _vName = ""
        }
        
        if let img = data["im:image"] as? JSONArray, image = img[2] as? JSONDictionnary, image2 = image["label"] as? String {
            _vImageUrl = image2.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
            _vImageUrl = ""
        }
        
        if let video = data["link"] as? JSONArray, vUrl = video[1] as? JSONDictionnary, vHref = vUrl["attributes"] as? JSONDictionnary, vVideoUrl = vHref["href"] as? String {
            _vVideoUrl = vVideoUrl
        } else
        {
            _vVideoUrl = ""
        }
    }
}