//
//  Question.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 22/9/23.
//

import Foundation

struct Observation: Identifiable, Hashable, Codable {
    var id = UUID()
    
    var studentsWorkingWithTechnology: ObservationRecord?
    var studentsDoingIndependentWork: ObservationRecord?
    var studentsDoingPairWork: ObservationRecord?
    var studentsDoingGroupWork: ObservationRecord?
    
    var technologyUsedByStudent: ObservationRecord?
    var howManyTimesTechnologyUsedByStudent: ObservationRecord?
    var typeOfTaskSetByTeacher: ObservationRecord?
    
    var whatIsTheTeacherDoing: ObservationRecord?
    var technologyUsedByTeacher: ObservationRecord?
    var howManyTimesWasTechnologyUsedByTeacher: ObservationRecord?
    var teacherConfidenceInTechnology: ObservationRecord?
    var questionsPosedByTeacherToStudents: ObservationRecord?
    
    var time: Date = .now
}

enum ObservationRecord: Hashable, Codable {
    case numeric(Int)
    case openEndedList([String])
    case options(String)
    
    var numericValue: Int? {
        switch self {
        case .numeric(let value): return value
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
        default: return nil
        }
    }
}

enum Question: Int, CaseIterable {
    case studentsWorkingWithTechnology
    case studentsDoingIndependentWork
    case studentsDoingPairWork
    case studentsDoingGroupWork
    
    case technologyUsedByStudent
    case howManyTimesTechnologyUsedByStudent
    case typeOfTaskSetByTeacher
    
    case whatIsTheTeacherDoing
    case technologyUsedByTeacher
    case howManyTimesWasTechnologyUsedByTeacher
    case teacherConfidenceInTechnology
    case questionsPosedByTeacherToStudents
    
    var symbol: String {
        switch self {
        case .studentsWorkingWithTechnology:
            return "laptopcomputer"
        case .studentsDoingIndependentWork:
            return "person"
        case .studentsDoingPairWork:
            return "person.2"
        case .studentsDoingGroupWork:
            return "person.3"
        case .technologyUsedByStudent:
            return "macbook.and.ipad"
        case .howManyTimesTechnologyUsedByStudent:
            return "number"
        case .typeOfTaskSetByTeacher:
            return "list.number"
        case .whatIsTheTeacherDoing:
            return "studentdesk"
        case .technologyUsedByTeacher:
            return "desktopcomputer"
        case .howManyTimesWasTechnologyUsedByTeacher:
            return "number"
        case .teacherConfidenceInTechnology:
            return "face.smiling"
        case .questionsPosedByTeacherToStudents:
            return "questionmark.bubble"
        }
    }
    
    var inputType: InputType {
        switch self {
        case .studentsWorkingWithTechnology:
            return .numeric
        case .studentsDoingIndependentWork:
            return .numeric
        case .studentsDoingPairWork:
            return .numeric
        case .studentsDoingGroupWork:
            return .numeric
        case .technologyUsedByStudent:
            return .openEndedList
        case .howManyTimesTechnologyUsedByStudent:
            return .numeric
        case .typeOfTaskSetByTeacher:
            return .options(["active", "collaborative", "constructive", "authentic", "goal directed"])
        case .whatIsTheTeacherDoing:
            return .options(["administration", "whole class instruction", "interacting with students"])
        case .technologyUsedByTeacher:
            return .openEndedList
        case .howManyTimesWasTechnologyUsedByTeacher:
            return .numeric
        case .teacherConfidenceInTechnology:
            return .scale(1...10)
        case .questionsPosedByTeacherToStudents:
            return .openEndedList
        }
    }
    
    var title: String {
        switch self {
        case .studentsWorkingWithTechnology:
            return "How many students are working with technology?"
        case .studentsDoingIndependentWork:
            return "How many students are doing [Independent Work](https://example.com)?"
        case .studentsDoingPairWork:
            return "How many students are doing [Pair Work](https://example.com)?"
        case .studentsDoingGroupWork:
            return "How many students are doing [Group Work](https://example.com)?"
        case .technologyUsedByStudent:
            return "What is the technology being used by students?"
        case .howManyTimesTechnologyUsedByStudent:
            return "How many times was each technology used by students?"
        case .typeOfTaskSetByTeacher:
            return "What was the type of task being set by the teacher for students?"
        case .whatIsTheTeacherDoing:
            return "What is the teacher doing?"
        case .technologyUsedByTeacher:
            return "What is the technology being used by the teacher?"
        case .howManyTimesWasTechnologyUsedByTeacher:
            return "How many times was each technology used by the teacher?"
        case .teacherConfidenceInTechnology:
            return "How confident was the teacher in the use of each technology?"
        case .questionsPosedByTeacherToStudents:
            return "What were the questions posed by the teacher to students?"
        }
    }
    
    var unformattedTitle: String {
        switch self {
        case .studentsWorkingWithTechnology:
            return "How many students are working with technology?"
        case .studentsDoingIndependentWork:
            return "How many students are doing Independent Work?"
        case .studentsDoingPairWork:
            return "How many students are doing Pair Work?"
        case .studentsDoingGroupWork:
            return "How many students are doing Group Work?"
        case .technologyUsedByStudent:
            return "What is the technology being used by students?"
        case .howManyTimesTechnologyUsedByStudent:
            return "How many times was each technology used by students?"
        case .typeOfTaskSetByTeacher:
            return "What was the type of task being set by the teacher for students?"
        case .whatIsTheTeacherDoing:
            return "What is the teacher doing?"
        case .technologyUsedByTeacher:
            return "What is the technology being used by the teacher?"
        case .howManyTimesWasTechnologyUsedByTeacher:
            return "How many times was each technology used by the teacher?"
        case .teacherConfidenceInTechnology:
            return "How confident was the teacher in the use of each technology?"
        case .questionsPosedByTeacherToStudents:
            return "What were the questions posed by the teacher to students?"
        }
    }
    
    var shorthandTitle: String {
        switch self {
        case .studentsWorkingWithTechnology:
            return "Students working with technology"
        case .studentsDoingIndependentWork:
            return "Independent work"
        case .studentsDoingPairWork:
            return "Pair work"
        case .studentsDoingGroupWork:
            return "Group work"
        case .technologyUsedByStudent:
            return "Technology used by students"
        case .howManyTimesTechnologyUsedByStudent:
            return "Technology use by the students"
        case .typeOfTaskSetByTeacher:
            return "Type of task set by the teacher"
        case .whatIsTheTeacherDoing:
            return "What is the teacher doing"
        case .technologyUsedByTeacher:
            return "Technology used by teacher"
        case .howManyTimesWasTechnologyUsedByTeacher:
            return "Technology use by the teacher"
        case .teacherConfidenceInTechnology:
            return "Teacher confidence in technology use"
        case .questionsPosedByTeacherToStudents:
            return "Questions posed by the teacher"
        }
    }
    
    var subtitle: String? {
        switch self {
        case .studentsWorkingWithTechnology:
            return nil
        case .studentsDoingIndependentWork:
            return nil
        case .studentsDoingPairWork:
            return nil
        case .studentsDoingGroupWork:
            return nil
        case .technologyUsedByStudent:
            return "List the hardware as well as the software application being used"
        case .howManyTimesTechnologyUsedByStudent:
            return nil
        case .typeOfTaskSetByTeacher:
            return nil
        case .whatIsTheTeacherDoing:
            return nil
        case .technologyUsedByTeacher:
            return "List the hardware as well as the software application being used"
        case .howManyTimesWasTechnologyUsedByTeacher:
            return nil
        case .teacherConfidenceInTechnology:
            return "On a scale of 1 to 10 with 1 being unconfident and 10 being highly confident"
        case .questionsPosedByTeacherToStudents:
            return "List down the questions posed (if any)"
        }
    }
    
    var path: WritableKeyPath<Observation, ObservationRecord?> {
        switch self {
        case .studentsWorkingWithTechnology:
            return \Observation.studentsWorkingWithTechnology
        case .studentsDoingIndependentWork:
            return \Observation.studentsDoingIndependentWork
        case .studentsDoingPairWork:
            return \Observation.studentsDoingPairWork
        case .studentsDoingGroupWork:
            return \Observation.studentsDoingGroupWork
        case .technologyUsedByStudent:
            return \Observation.technologyUsedByStudent
        case .howManyTimesTechnologyUsedByStudent:
            return \Observation.howManyTimesTechnologyUsedByStudent
        case .typeOfTaskSetByTeacher:
            return \Observation.typeOfTaskSetByTeacher
        case .whatIsTheTeacherDoing:
            return \Observation.whatIsTheTeacherDoing
        case .technologyUsedByTeacher:
            return \Observation.technologyUsedByTeacher
        case .howManyTimesWasTechnologyUsedByTeacher:
            return \Observation.howManyTimesWasTechnologyUsedByTeacher
        case .teacherConfidenceInTechnology:
            return \Observation.teacherConfidenceInTechnology
        case .questionsPosedByTeacherToStudents:
            return \Observation.questionsPosedByTeacherToStudents
        }
    }
}

enum InputType {
    case numeric
    case openEndedList
    case options([String])
    case scale(ClosedRange<Int>)
}
