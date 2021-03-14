//
//  TopFreeModel.swift
//  PracticalTask
//
//  Created by Uttam Bhoj on 08/03/21.
//

import Foundation

class TopFreeModel {
    
    var artistName: String = ""
    var artistId: String = ""
    var id : String = ""
    var name : String = ""
    var logo : String = ""
    var appUrl : String = ""
    
    init(_ dict : NSDictionary) {
        
        if let artistName = dict.object(forKey: "artistName") as? String {
            self.artistName = artistName
        }
        if let artistId = dict.object(forKey: "artistId") as? String {
            self.artistId = artistId
        }
        if let id = dict.object(forKey: "id") as? String {
            self.id = id
        }
        if let name = dict.object(forKey: "name") as? String {
            self.name = name
        }
        if let logo = dict.object(forKey: "artworkUrl100") as? String {
            self.logo = logo
        }
        if let appUrl = dict.object(forKey: "url") as? String {
            self.appUrl = appUrl
        }
    }
}
