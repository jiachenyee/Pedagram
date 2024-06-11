//
//  Question+Codable.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 15/4/24.
//

import Foundation

extension Question: Codable, Equatable {
    func encode(to encoder: any Encoder) throws {
        var singleValueEncoder = encoder.singleValueContainer()
        try singleValueEncoder.encode(rawValue)
    }
    
    init(from decoder: any Decoder) throws {
        let singleValueContainer = try decoder.singleValueContainer()
        let rawValue = try singleValueContainer.decode(Int.self)
        
        self = Self.allCases[rawValue]
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.title == rhs.title
    }
}
