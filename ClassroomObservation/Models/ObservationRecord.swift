//
//  ObservationRecord.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 15/4/24.
//

import Foundation

struct ScaleComments: Codable, Equatable, Hashable {
    var scaleValue: Int
    var comments: String
}

enum ObservationRecord: Hashable, Codable {
    case numeric(Int)
    case openEndedList([String])
    case options(String)
    case scaleComments(ScaleComments)
    
    case dict([String: [String]])
    case string(String)
    
    var numericValue: Int? {
        switch self {
        case .numeric(let value): return value
        case .scaleComments(let value): return value.scaleValue
        default: return nil
        }
    }
    
    var scaleComments: ScaleComments? {
        switch self {
        case .scaleComments(let value): return value
        default: return nil
        }
    }
    
    var stringArrayValue: [String]? {
        switch self {
        case .openEndedList(let value): return value
        default: return nil
        }
    }
    
    var stringValue: String? {
        switch self {
        case .options(let value): return value
        case .string(let value): return value
        default: return nil
        }
    }
    
    var dictValue: [String: [String]]? {
        switch self {
        case .dict(let value): return value
        default: return nil
        }
    }
    
    var value: String {
        switch self {
        case .numeric(let value): return "\(value)"
        case .openEndedList(let value): return value.filter({ !$0.isEmpty }).joined(separator: ", ")
        case .options(let value): return value.capitalized
        case .dict(let value):
            return value.map { (key, count) in
                "\(key): \(count)"
            }
            .joined(separator: "\n")
        case .string(let value): return value
        case .scaleComments(let value):
            return value.comments.isEmpty ? "\(value.scaleValue)" : "\(value.scaleValue)\n\(value.comments)"
        }
    }
}
