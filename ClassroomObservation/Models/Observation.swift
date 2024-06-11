//
//  Observation.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 15/4/24.
//

import Foundation

struct Observation: Identifiable, Hashable, Codable {
    var id = UUID()
    
    var studentsWorkingWithTechnology: ObservationRecord?
    var studentsDoingIndependentWork: ObservationRecord?
    var studentsDoingPairWork: ObservationRecord?
    var studentsDoingGroupWork: ObservationRecord?
    
    var whatIsTheTeacherDoing: ObservationRecord?
    var technologyUsedByTeacher: ObservationRecord?
    var howIsTheTeacherUsingTechnology: ObservationRecord?
    var questionsPosedByTeacherToStudents: ObservationRecord?
    
    var whatIsTheLevelOfStudentEngagement: ObservationRecord?
    
    var comments: ObservationRecord?
    
    var time: Date = .now
}
