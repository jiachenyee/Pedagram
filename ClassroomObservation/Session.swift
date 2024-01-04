//
//  Session.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 26/9/23.
//

import Foundation

struct Session: Identifiable, Hashable, Codable {
    var id = UUID()
    var `class`: String
    var grade: String
    var enrolment: Int
    var lessonTime: Date
    var duration: TimeInterval
    
    var observations: [Observation]
    var sortedObservations: [Observation] {
        observations.sorted {
            $0.time > $1.time
        }
    }
}
