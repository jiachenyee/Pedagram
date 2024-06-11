//
//  Question+Implementation.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 15/4/24.
//

import Foundation

extension Question {
    static let allCases = [
        studentsWorkingWithTechnology,
        studentsDoingIndependentWork,
        studentsDoingPairWork,
        studentsDoingGroupWork,
        whatIsTheLevelOfStudentEngagement,
        whatIsTheTeacherDoing,
        technologyUsedByTeacher,
        howIsTheTeacherUsingTechnology,
        questionsPosedByTeacherToStudents,
        comments
    ]
    
    static let studentsWorkingWithTechnology = Question(inputType: .numeric, title: "How many students are working with technology?", unformattedTitle: "How many students are working with technology?", shorthandTitle: "Students working with technology", path: \.studentsWorkingWithTechnology)
    static let studentsDoingIndependentWork = Question(inputType: .numeric, title: "How many students are doing [Independent Work](https://example.com)?", unformattedTitle: "How many students are doing Independent Work?", shorthandTitle: "Independent work", path: \.studentsDoingIndependentWork)
    static let studentsDoingPairWork = Question(inputType: .numeric, title: "How many students are doing [Pair Work](https://example.com)?", unformattedTitle: "How many students are doing Pair Work?", shorthandTitle: "Pair work", path: \.studentsDoingPairWork)
    static let studentsDoingGroupWork = Question(inputType: .numeric, title: "How many students are doing [Group Work](https://example.com)?", unformattedTitle: "How many students are doing Group Work?", shorthandTitle: "Group work", path: \.studentsDoingGroupWork)
    
    static let whatIsTheLevelOfStudentEngagement = Question(inputType: .scale, title: "What is the level of student engagement?", shorthandTitle: "Student Engagement", subtitle: "On a scale of 1 to 5, with 1 being not engaged and 5 being highly engaged.\n\nConsider the following:\n• Content is presented to students in multiple modalities\n• Students choose what and how they use technology\n• Students choose how they complete the given task", path: \.whatIsTheLevelOfStudentEngagement)
    
    static let whatIsTheTeacherDoing = Question(inputType: .options(["administration", "whole class instruction", "interacting with students"].map({
        ChecklistOption(title: $0)
    })), title: "What is [the teacher](https://example.com) doing?", unformattedTitle: "What is the teacher doing?", path: \.whatIsTheTeacherDoing)
    
    static let technologyUsedByTeacher = Question(inputType: .openEndedList, title: "What is the technology being used [by the teacher](https://example.com)?", unformattedTitle: "What is the technology being used by the teacher?", shorthandTitle: "Technology used by teacher", subtitle: "List the hardware as well as the software application being used", path: \.technologyUsedByTeacher, supportsAutocomplete: true)
    static let howIsTheTeacherUsingTechnology = Question(inputType: .dict(\.technologyUsedByTeacher), title: "How is the teacher using each technology?", subtitle: "What is the purpose of each tool (from the previous question) in the classroom?\nSelect all that apply.", path: \.howIsTheTeacherUsingTechnology)
    static let questionsPosedByTeacherToStudents = Question(inputType: .openEndedList, title: "What were the questions posed by the teacher to students?", shorthandTitle: "Questions posed by the teacher", subtitle: "List down the questions posed (if any)", path: \.questionsPosedByTeacherToStudents)
    
    static let comments = Question(inputType: .text, title: "Any final comments?", shorthandTitle: "Comments", subtitle: "Optional", path: \.comments)
}
