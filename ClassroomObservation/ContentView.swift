//
//  ContentView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 22/9/23.
//

import SwiftUI
import Forever

struct ContentView: View {
    
    @State private var isNewSessionPresented = false
    
    @Forever("observations") private var sessions: [Session] = [
//        .init(class: "Math", grade: "7", enrolment: 30, lessonTime: .now, duration: TimeInterval(60*60), observations: [
//            Observation(studentsWorkingWithTechnology: .numeric(20), studentsDoingIndependentWork: .numeric(4), studentsDoingPairWork: .numeric(5),
//                        studentsDoingGroupWork: .numeric(6),
//                        technologyUsedByStudent: .openEndedList(["iPad", "Mac", "Keynote", "Clips"]),
//                        howManyTimesTechnologyUsedByStudent: .numeric(5), technologyUsedByTeacher: .openEndedList(["iPad", "Mac", "Keynote", "Clips"]),
//                        howManyTimesWasTechnologyUsedByTeacher: .numeric(8),
//                        time: .now.addingTimeInterval(10)),
//            Observation(studentsWorkingWithTechnology: .numeric(10), studentsDoingIndependentWork: .numeric(6), studentsDoingPairWork: .numeric(5), studentsDoingGroupWork: .numeric(6),
//                        technologyUsedByStudent: .openEndedList(["iPad", "Mac", "Keynote", "Clips"]),
//                        howManyTimesTechnologyUsedByStudent: .numeric(4),
//                        howManyTimesWasTechnologyUsedByTeacher: .numeric(2),
//                        teacherConfidenceInTechnology: .numeric(5),
//                        time: .now.addingTimeInterval(20)),
//            Observation(studentsWorkingWithTechnology: .numeric(10), studentsDoingIndependentWork: .numeric(6), studentsDoingPairWork: .numeric(5), studentsDoingGroupWork: .numeric(6),
//                        technologyUsedByStudent: .openEndedList(["iPad", "Mac", "Keynote", "Clips"]),
//                        howManyTimesTechnologyUsedByStudent: .numeric(4),
//                        howManyTimesWasTechnologyUsedByTeacher: .numeric(2),
//                        teacherConfidenceInTechnology: .numeric(5),
//                        time: .now.addingTimeInterval(30)),
//            Observation(studentsWorkingWithTechnology: .numeric(15), studentsDoingIndependentWork: .numeric(2), studentsDoingPairWork: .numeric(5), studentsDoingGroupWork: .numeric(6),
//                        technologyUsedByStudent: .openEndedList(["iPad", "Potato"]),
//                        howManyTimesTechnologyUsedByStudent: .numeric(7),
//                        howManyTimesWasTechnologyUsedByTeacher: .numeric(7),
//                        teacherConfidenceInTechnology: .numeric(9),
//                        questionsPosedByTeacherToStudents: .openEndedList(["What time is it?", "Hot chocolate?", "Yes"]),
//                        time: .now.addingTimeInterval(40))
//        ])
    ]
    
    @State private var navigationSplitViewVisibility = NavigationSplitViewVisibility.doubleColumn
    
    var body: some View {
        NavigationSplitView(columnVisibility: $navigationSplitViewVisibility) {
            List($sessions, editActions: .all) { $session in
                NavigationLink {
                    SessionView(session: $session)
                } label: {
                    Text(session.class)
                }
            }
            .overlay {
                if sessions.isEmpty {
                    ContentUnavailableView {
                        Label("No Sessions Available", systemImage: "list.clipboard")
                    } description: {
                        Text("Create a new session to get started!")
                    } actions: {
                        Button {
                            isNewSessionPresented.toggle()
                        } label: {
                            Text("Create New Session")
                        }
                    }
                }
            }
            .navigationTitle("Sessions")
            .toolbar {
                Button {
                    isNewSessionPresented.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isNewSessionPresented) {
                NewSessionView { record in
                    sessions.insert(record, at: 0)
                }
            }
        } detail: {
            ContentUnavailableView {
                Label("Nothing Selected", systemImage: "square.and.pencil")
            } description: {
                Text("Select a session to open it!")
            } actions: {
                Button {
                    isNewSessionPresented.toggle()
                } label: {
                    Text("Create New Session")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
