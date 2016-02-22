//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Marco Guilmette on 2016-02-20.
//  Copyright © 2016 Marco Guilmette. All rights reserved.
//

import Foundation

class Videos {
    
    var vRank = 0
    
    private var _vName:String
    private var _vRights:String
    private var _vPrice:String
    private var _vImageUrl:String
    private var _vArtist:String
    private var _vVideoUrl:String
    private var _vImid:String
    private var _vGenre:String
    private var _vLinkToiTunes:String
    private var _vReleaseDate:String
    
    // This variable gets created from the UI
    var vImageData:NSData?
    
    var vName: String { return _vName }
    var vRights: String { return _vRights }
    var vPrice: String { return _vPrice }
    var vImageUrl: String { return _vImageUrl }
    var vArtist: String { return _vArtist }
    var vVideoUrl: String { return _vVideoUrl }
    var vImid: String { return _vImid }
    var vGenre: String { return _vGenre }
    var vLinkToiTunes: String { return _vLinkToiTunes }
    var vReleaseDate: String { return _vReleaseDate }

    
    init(data: JSONDictionnary) {
        if let name = data["im:name"] as? JSONDictionnary, vName = name["label"] as? String {
            self._vName = vName
        } else {
             self._vName = ""
        }
        
        if let rights = data["rights"] as? JSONDictionnary, vRights = rights["label"] as? String {
            self._vRights =  vRights
        } else {
             self._vRights = ""
        }
        
        if let price = data["im:price"] as? JSONDictionnary, vPrice = price["label"] as? String {
            self._vPrice = vPrice
        } else {
            self._vPrice = ""
        }
        
        if let img = data["im:image"] as? JSONArray, image = img[2] as? JSONDictionnary, image2 = image["label"] as? String {
             self._vImageUrl = image2.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
             self._vImageUrl = ""
        }
        
        if let artist = data["im:artist"] as? JSONDictionnary, vArtist = artist["label"] as? String {
            self._vArtist = vArtist
        } else {
            self._vArtist = ""
        }
        
        
        if let video = data["link"] as? JSONArray, vUrl = video[1] as? JSONDictionnary, vHref = vUrl["attributes"] as? JSONDictionnary, vVideoUrl = vHref["href"] as? String {
             self._vVideoUrl = vVideoUrl
        } else
        {
             self._vVideoUrl = ""
        }
        
        if let category = data["category"] as? JSONDictionnary, attributes = category["attributes"]  as? JSONDictionnary, imid = attributes["im:id"] as? String {
            self._vImid = imid
        } else {
            self._vImid = ""
        }
        
        
        if let category = data["category"] as? JSONDictionnary, attributes = category["attributes"]  as? JSONDictionnary, term = attributes["term"] as? String {
            self._vGenre = term
        } else {
            self._vGenre = ""
        }
        
        
        if let linktoiTunes = data["id"] as? JSONDictionnary, vLinktoiTunes = linktoiTunes["label"] as? String {
            self._vLinkToiTunes = vLinktoiTunes
        } else {
            self._vLinkToiTunes = ""
        }
        
        
        if let releaseDate = data["im:releaseDate"] as? JSONDictionnary, vReleaseData = releaseDate["label"] as? String {
            self._vReleaseDate = vReleaseData
        } else {
            self._vReleaseDate = ""
        }
    
    }
}