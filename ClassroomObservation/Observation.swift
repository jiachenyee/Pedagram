//
//  Observation.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 26/9/23.
//

import Foundation

struct Observation: Identifiable, Hashable {
    var id = UUID()
    var `class`: String
    var grade: String
    var enrolment: Int
    var lessonTime: Date
    var duration: TimeInterval
    
    var entries: [Entry]
}
