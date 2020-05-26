//
//  Episode.swift
//  MindValley
//
//  Created by Sudhanshu Sharma (HLB) on 19/05/2020.
//  Copyright © 2020 Sudhanshu Sharma (HLB). All rights reserved.
//

import Foundation


struct Episode: Codable {
    
    let type, title: String
    let channel : ChannelEpisode
    let coverAsset : CoverAsset

    enum CodingKeys: String, CodingKey {
        case type, title
        case channel = "channel"
        case coverAsset
    }
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(Episode.self, from: data) else { return nil }
        self = me
    }
}

// MARK: Convenience initializers

struct ChannelEpisode : Codable {
    let title : String
    
    enum CodingKeys: String, CodingKey {
        case title
    }
}

struct CoverAsset : Codable {
    let url : String
    
    enum CodingKeys: String, CodingKey {
        case url
    }
}


