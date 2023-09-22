//
//  NewObservationView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 28/9/23.
//

import SwiftUI

struct NewObservationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var observation = Observation(class: "",
                                                 grade: "",
                                                 enrolment: 30,
                                                 lessonTime: .now,
                                                 duration: 0,
                                                 entries: [])
    
    var completion: ((Observation) -> Void)
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Class") {
                    TextField("Class", text: $observation.class)
                }
                Section("Grade") {
                    TextField("Grade", text: $observation.grade)
                }
                
                Section("Enrolment") {
                    Stepper {
                        Text("\(observation.enrolment)")
                    } onIncrement: {
                        observation.enrolment += 1
                    } onDecrement: {
                        if observation.enrolment > 0 {
                            observation.enrolment -= 1
                        }
                    }
                }
                
                Section("Date/Time") {
                    DatePicker("Lesson Time", selection: $observation.lessonTime, displayedComponents: [.date, .hourAndMinute])
                }
                
                Section("Date/Time") {
                    Picker("Duration", selection: $observation.duration) {
                        ForEach([15, 30, 45, 60, 75, 90, 105, 120], id: \.self) { duration in
                            let hours = duration / 60
                            let minutes = duration % 60
                            
                            if hours == 0 {
                                Text("\(minutes) minutes")
                            } else if minutes == 0 {
                                Text("\(hours) hours")
                            } else {
                                Text("\(hours) hours \(minutes) minutes")
                            }
                        }
                        
                        Text("Custom")
                    }
                }
                
                Button("Create") {
                    dismiss()
                    withAnimation {
                        completion(observation)
                    }
                }
            }
            .navigationTitle("New Observation")
        }
    }
}
