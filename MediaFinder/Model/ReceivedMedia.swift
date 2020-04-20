//
//  File.swift
//  RegistrationApp
//
//  Created by Ziad on 2/26/20.
//  Copyright © 2020 intake4. All rights reserved.
//

import Foundation

enum Kind: String {
    case tvShow = "tv-episode"
    case movie = "feature-movie"
    case music = "song"
}


struct ReceivedMedia: Decodable {
    
    var imageURL: String
    var artistName: String
    var trackName: String?
    var longDescription: String?
    var previewUrl: String?
    var kind: String?
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "artworkUrl100"
        case artistName
        case trackName
        case longDescription
        case previewUrl
        case kind
    }
    
    func getKind() -> String? {
        return self.kind
    }
}

struct Results: Decodable {
    var resultCount: Int
    var results: [ReceivedMedia]
}

