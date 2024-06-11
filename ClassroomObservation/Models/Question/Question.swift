//
//  Question.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 22/9/23.
//

import Foundation

struct Question {
    
    var rawValue: Int {
        Self.allCases.firstIndex(of: self)!
    }
    
    var inputType: InputType
    var title: String
    var unformattedTitle: String
    var shorthandTitle: String
    var subtitle: String?
    
    var path: WritableKeyPath<Observation, ObservationRecord?>
    var supportsAutocomplete: Bool = false
    
    init(inputType: InputType,
         title: String,
         unformattedTitle: String? = nil,
         shorthandTitle: String? = nil,
         subtitle: String? = nil,
         path: WritableKeyPath<Observation, ObservationRecord?>,
         supportsAutocomplete: Bool = false) {
        self.inputType = inputType
        self.title = title
        
        if let unformattedTitle {
            self.unformattedTitle = unformattedTitle
        } else {
            self.unformattedTitle = title
        }
        
        if let shorthandTitle {
            self.shorthandTitle = shorthandTitle
        } else if let unformattedTitle {
            self.shorthandTitle = unformattedTitle
        } else {
            self.shorthandTitle = title
        }
        
        self.subtitle = subtitle
        self.path = path
        self.supportsAutocomplete = supportsAutocomplete
    }
    
    init?(rawValue: Int) {
        guard rawValue >= 0, rawValue < Self.allCases.count else {
            return nil
        }
        
        self = Self.allCases[rawValue]
    }
}
