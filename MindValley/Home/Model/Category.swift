//
//  Category.swift
//  MindValley
//
//  Created by Sudhanshu Sharma (HLB) on 22/05/2020.
//  Copyright © 2020 Sudhanshu Sharma (HLB). All rights reserved.
//

import Foundation

struct Category : Codable {
    let name : String
    
    enum CodingKeys: String, CodingKey {
           case  name
           
       }
}

extension Category {
    init?(data: Data) {
        do {
            let me = try JSONDecoder().decode(Category.self, from: data)
            self = me
        }
        catch {
            print(error)
            return nil
        }
    }
}

