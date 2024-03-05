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
    
    var durationMinutes: Int {
        get {
            Int(duration / 60)
        }
        set {
            duration = TimeInterval(newValue) * 60
        }
    }
    
    var observations: [Observation]
    var sortedObservations: [Observation] {
        observations.sorted {
            $0.time > $1.time
        }
    }
    
    var state: SessionState = .notStarted
    
    enum SessionState: Codable {
        case notStarted
        case recording
        case finished
    }
}
