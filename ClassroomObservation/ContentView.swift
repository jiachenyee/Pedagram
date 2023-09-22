//
//  ContentView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 22/9/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNewObservationPresented = false
    
    @State private var observations: [Observation] = [
        .init(class: "Math", grade: "7", enrolment: 30, lessonTime: .now, duration: TimeInterval(60*60), entries: [
            Entry(studentsWorkingWithTechnology: .numeric(20), studentsDoingIndependentWork: .numeric(4), studentsDoingPairWork: .numeric(5),
                  studentsDoingGroupWork: .numeric(6),
                  technologyUsedByStudent: .openEndedList(["iPad", "Mac", "Keynote", "Clips"]),
                  howManyTimesTechnologyUsedByStudent: .numeric(5),
                  howManyTimesWasTechnologyUsedByTeacher: .numeric(8),
                  time: .now.addingTimeInterval(10)),
            Entry(studentsWorkingWithTechnology: .numeric(10), studentsDoingIndependentWork: .numeric(6), studentsDoingPairWork: .numeric(5), studentsDoingGroupWork: .numeric(6),
                  technologyUsedByStudent: .openEndedList(["iPad", "Mac", "Keynote", "Clips"]),
                  howManyTimesTechnologyUsedByStudent: .numeric(4),
                  howManyTimesWasTechnologyUsedByTeacher: .numeric(2),
                  teacherConfidenceInTechnology: .numeric(5),
                  time: .now.addingTimeInterval(20)),
            Entry(studentsWorkingWithTechnology: .numeric(10), studentsDoingIndependentWork: .numeric(6), studentsDoingPairWork: .numeric(5), studentsDoingGroupWork: .numeric(6),
                  technologyUsedByStudent: .openEndedList(["iPad", "Mac", "Keynote", "Clips"]),
                  howManyTimesTechnologyUsedByStudent: .numeric(4),
                  howManyTimesWasTechnologyUsedByTeacher: .numeric(2),
                  teacherConfidenceInTechnology: .numeric(5),
                  time: .now.addingTimeInterval(30)),
            Entry(studentsWorkingWithTechnology: .numeric(15), studentsDoingIndependentWork: .numeric(2), studentsDoingPairWork: .numeric(5), studentsDoingGroupWork: .numeric(6),
                  technologyUsedByStudent: .openEndedList(["iPad", "Potato"]),
                  howManyTimesTechnologyUsedByStudent: .numeric(7),
                  howManyTimesWasTechnologyUsedByTeacher: .numeric(7),
                  teacherConfidenceInTechnology: .numeric(9),
                  time: .now.addingTimeInterval(40))
        ])
    ]
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach($observations) { $observation in
                    NavigationLink(observation.class, value: observation)
                }
            }
            .navigationDestination(for: Observation.self, destination: { observation in
                let index = observations.firstIndex {
                    $0.id == observation.id
                }
                
                ObservationView(observation: $observations[index!])
            })
            .navigationTitle("My Observations")
            .toolbar {
                Button {
                    
                } label: {
                    Button {
                        isNewObservationPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isNewObservationPresented) {
                NewObservationView { observation in
                    observations.insert(observation, at: 0)
                }
            }
        } detail: {
            Text("Select an Observation")
        }
    }
}

#Preview {
    ContentView()
}
