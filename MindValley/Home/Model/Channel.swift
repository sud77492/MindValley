//
//  Channel.swift
//  MindValley
//
//  Created by Sudhanshu Sharma (HLB) on 24/05/2020.
//  Copyright © 2020 Sudhanshu Sharma (HLB). All rights reserved.
//

import Foundation

struct Channel : Codable{
    let title: String
    let mediaCount : Int
    let latestMedia: [LatestMedia]
    let series : [Series]
    let iconAsset : IconAsset
    let coverAsset : CoverAsset
    
    enum CodingKeys: String, CodingKey {
        case title
        case mediaCount
        case latestMedia, series
        case iconAsset, coverAsset
    }
    
}

struct Series : Codable {
    let title : String
    let coverAsset : CoverAsset
}

struct LatestMedia : Codable {
    let type, title : String
    let coverAsset : CoverAsset
    
    enum CodingKeys: String, CodingKey {
        case type, title
        case coverAsset
    }
    
}

struct IconAsset : Codable {
    let thumbnailUrl : String
    
    enum CodingKeys: String, CodingKey {
        case thumbnailUrl
    }
    
}

extension Channel {
    init?(data: Data) {
        do {
            let me = try JSONDecoder().decode(Channel.self, from: data)
            self = me
        }
        catch {
            print(error)
            return nil
        }
    }
}

