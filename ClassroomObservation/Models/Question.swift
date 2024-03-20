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
    var howConfidentWereStudentsInTheUseOfEachTechnology: ObservationRecord?
    var typeOfTaskSetByTeacher: ObservationRecord?
    
    var whatIsTheTeacherDoing: ObservationRecord?
    var technologyUsedByTeacher: ObservationRecord?
    var howManyTimesWasTechnologyUsedByTeacher: ObservationRecord?
    var teacherConfidenceInTechnology: ObservationRecord?
    var questionsPosedByTeacherToStudents: ObservationRecord?
    
    var comments: ObservationRecord?
    
    var time: Date = .now
}

enum ObservationRecord: Hashable, Codable {
    case numeric(Int)
    case openEndedList([String])
    case options(String)
    
    case dict([String: Int])
    case string(String)
    
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
        case .string(let value): return value
        default: return nil
        }
    }
    
    var dictValue: [String: Int]? {
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
        }
    }
}

enum Question: Int, CaseIterable {
    case studentsWorkingWithTechnology
    case studentsDoingIndependentWork
    case studentsDoingPairWork
    case studentsDoingGroupWork
    
    case technologyUsedByStudent
    case howConfidentWereStudentsInTheUseOfEachTechnology
    case typeOfTaskSetByTeacher
    
    case whatIsTheTeacherDoing
    case technologyUsedByTeacher
    case teacherConfidenceInTechnology
    case questionsPosedByTeacherToStudents
    
    case comments
    
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
        case .howConfidentWereStudentsInTheUseOfEachTechnology:
            return "number"
        case .typeOfTaskSetByTeacher:
            return "list.number"
        case .whatIsTheTeacherDoing:
            return "studentdesk"
        case .technologyUsedByTeacher:
            return "desktopcomputer"
        case .teacherConfidenceInTechnology:
            return "face.smiling"
        case .questionsPosedByTeacherToStudents:
            return "questionmark.bubble"
        case .comments:
            return "ellipsis.bubble"
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
        case .howConfidentWereStudentsInTheUseOfEachTechnology:
            return .dict(\.technologyUsedByStudent)
        case .typeOfTaskSetByTeacher:
            return .options([
                ChecklistOption(title: "active", description: "Students are engaged in using technology as a tool rather than passively receiving information from the technology."),
                ChecklistOption(title: "collaborative", description: "Students use technology tools to collaborate with others rather than working individually at all times."),
                ChecklistOption(title: "constructive", description: "Students use technology tools to connect new information to their prior knowledge rather than to passively receive information."),
                ChecklistOption(title: "authentic", description: "Students use technology tools to link learning activities to the world beyond the instructional setting rather than working on decontextualized assignments."),
                ChecklistOption(title: "goal directed", description: "Students use technology tools to set goals, plan activities, monitor progress, and evaluate results rather than simply completing assignments without reflection.")
            ])
        case .whatIsTheTeacherDoing:
            return .options(["administration", "whole class instruction", "interacting with students"].map({
                ChecklistOption(title: $0)
            }))
        case .technologyUsedByTeacher:
            return .openEndedList
        case .teacherConfidenceInTechnology:
            return .dict(\.technologyUsedByTeacher)
        case .questionsPosedByTeacherToStudents:
            return .openEndedList
        case .comments:
            return .text
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
            return "What is the technology being used [by students](https://example.com)?"
        case .howConfidentWereStudentsInTheUseOfEachTechnology:
            return "How confident were the students in the use of each technology used?"
        case .typeOfTaskSetByTeacher:
            return "What was the type of task being set by the teacher for students?"
        case .whatIsTheTeacherDoing:
            return "What is [the teacher](https://example.com) doing?"
        case .technologyUsedByTeacher:
            return "What is the technology being used [by the teacher](https://example.com)?"
        case .teacherConfidenceInTechnology:
            return "How confident was the teacher in the use of each technology?"
        case .questionsPosedByTeacherToStudents:
            return "What were the questions posed by the teacher to students?"
        case .comments:
            return "Any final comments?"
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
        case .howConfidentWereStudentsInTheUseOfEachTechnology:
            return "How confident were the students in the use of each technology?"
        case .typeOfTaskSetByTeacher:
            return "What was the type of task being set by the teacher for students?"
        case .whatIsTheTeacherDoing:
            return "What is the teacher doing?"
        case .technologyUsedByTeacher:
            return "What is the technology being used by the teacher?"
        case .teacherConfidenceInTechnology:
            return "How confident was the teacher in the use of each technology?"
        case .questionsPosedByTeacherToStudents:
            return "What were the questions posed by the teacher to students?"
        case .comments:
            return "Any final comments?"
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
        case .howConfidentWereStudentsInTheUseOfEachTechnology:
            return "Student confidence in technology"
        case .typeOfTaskSetByTeacher:
            return "Type of task set by the teacher"
        case .whatIsTheTeacherDoing:
            return "What is the teacher doing"
        case .technologyUsedByTeacher:
            return "Technology used by teacher"
        case .teacherConfidenceInTechnology:
            return "Teacher confidence in technology use"
        case .questionsPosedByTeacherToStudents:
            return "Questions posed by the teacher"
        case .comments:
            return "Comments"
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
        case .howConfidentWereStudentsInTheUseOfEachTechnology:
            return "On a scale of 1 to 5 with 1 being unconfident and 5 being highly confident"
        case .typeOfTaskSetByTeacher:
            return nil
        case .whatIsTheTeacherDoing:
            return nil
        case .technologyUsedByTeacher:
            return "List the hardware as well as the software application being used"
        case .teacherConfidenceInTechnology:
            return "On a scale of 1 to 5 with 1 being unconfident and 5 being highly confident"
        case .questionsPosedByTeacherToStudents:
            return "List down the questions posed (if any)"
        case .comments:
            return "Optional"
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
        case .howConfidentWereStudentsInTheUseOfEachTechnology:
            return \Observation.howConfidentWereStudentsInTheUseOfEachTechnology
        case .typeOfTaskSetByTeacher:
            return \Observation.typeOfTaskSetByTeacher
        case .whatIsTheTeacherDoing:
            return \Observation.whatIsTheTeacherDoing
        case .technologyUsedByTeacher:
            return \Observation.technologyUsedByTeacher
        case .teacherConfidenceInTechnology:
            return \Observation.teacherConfidenceInTechnology
        case .questionsPosedByTeacherToStudents:
            return \Observation.questionsPosedByTeacherToStudents
        case .comments:
            return \Observation.comments
        }
    }
}

enum InputType {
    case numeric
    case openEndedList
    case options([ChecklistOption])
    case scale
    case dict(WritableKeyPath<Observation, ObservationRecord?>)
    case text
}
