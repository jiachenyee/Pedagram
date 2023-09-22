//
//  Question.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 22/9/23.
//

import Foundation

struct Entry: Identifiable, Hashable {
    var id = UUID()
    
    var studentsWorkingWithTechnology: EntryRecord?
    var studentsDoingIndependentWork: EntryRecord?
    var studentsDoingPairWork: EntryRecord?
    var studentsDoingGroupWork: EntryRecord?
    
    var technologyUsedByStudent: EntryRecord?
    var howManyTimesTechnologyUsedByStudent: EntryRecord?
    var typeOfTaskSetByTeacher: EntryRecord?
    
    var whatIsTheTeacherDoing: EntryRecord?
    var technologyUsedByTeacher: EntryRecord?
    var howManyTimesWasTechnologyUsedByTeacher: EntryRecord?
    var teacherConfidenceInTechnology: EntryRecord?
    var questionsPosedByTeacherToStudents: EntryRecord?
    
    var time: Date = .now
}

enum EntryRecord: Hashable {
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
    
    var path: WritableKeyPath<Entry, EntryRecord?> {
        switch self {
        case .studentsWorkingWithTechnology:
            return \Entry.studentsWorkingWithTechnology
        case .studentsDoingIndependentWork:
            return \Entry.studentsDoingIndependentWork
        case .studentsDoingPairWork:
            return \Entry.studentsDoingPairWork
        case .studentsDoingGroupWork:
            return \Entry.studentsDoingGroupWork
        case .technologyUsedByStudent:
            return \Entry.technologyUsedByStudent
        case .howManyTimesTechnologyUsedByStudent:
            return \Entry.howManyTimesTechnologyUsedByStudent
        case .typeOfTaskSetByTeacher:
            return \Entry.typeOfTaskSetByTeacher
        case .whatIsTheTeacherDoing:
            return \Entry.whatIsTheTeacherDoing
        case .technologyUsedByTeacher:
            return \Entry.technologyUsedByTeacher
        case .howManyTimesWasTechnologyUsedByTeacher:
            return \Entry.howManyTimesWasTechnologyUsedByTeacher
        case .teacherConfidenceInTechnology:
            return \Entry.teacherConfidenceInTechnology
        case .questionsPosedByTeacherToStudents:
            return \Entry.questionsPosedByTeacherToStudents
        }
    }
}

enum InputType {
    case numeric
    case openEndedList
    case options([String])
    case scale(ClosedRange<Int>)
}
