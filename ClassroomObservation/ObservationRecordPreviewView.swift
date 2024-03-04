//
//  ObservationRecordPreviewView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 4/3/24.
//

import SwiftUI

struct ObservationRecordPreviewView: View {
    
    var observation: Observation
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
//                    studentsWorkingWithTechnology
//                    studentsDoingIndependentWork
//                    studentsDoingPairWork
//                    studentsDoingGroupWork
//                    technologyUsedByStudent
//                    howManyTimesTechnologyUsedByStudent
//                    typeOfTaskSetByTeacher
//                    whatIsTheTeacherDoing
//                    technologyUsedByTeacher
//                    howManyTimesWasTechnologyUsedByTeacher
//                    teacherConfidenceInTechnology
//                    questionsPosedByTeacherToStudents
                    
                    
                    
                }
            }
            .navigationTitle("Observation at" + observation.time.formatted(date: .omitted, time: .shortened))
        }
    }
}
