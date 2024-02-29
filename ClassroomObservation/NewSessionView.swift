//
//  NewSessionView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 28/9/23.
//

import SwiftUI

struct NewSessionView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var session = Session(class: "",
                                         grade: "",
                                         enrolment: 30,
                                         lessonTime: .now,
                                         duration: 0,
                                         observations: [])
    
    var completion: ((Session) -> Void)
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Class") {
                    TextField("Class", text: $session.class)
                }
                Section("Grade") {
                    TextField("Grade", text: $session.grade)
                }
                
                Section("Enrolment") {
                    Stepper {
                        Text("\(session.enrolment)")
                    } onIncrement: {
                        session.enrolment += 1
                    } onDecrement: {
                        if session.enrolment > 0 {
                            session.enrolment -= 1
                        }
                    }
                }
                
                Section("Date/Time") {
                    DatePicker("Lesson Time", selection: $session.lessonTime, displayedComponents: [.date, .hourAndMinute])
                }
                
                Section("Class Duration") {
                    Picker("Duration", selection: $session.durationMinutes) {
                        ForEach([15, 30, 45, 60, 75, 90, 105, 120], id: \.self) { duration in
                            let hours = duration / 60
                            let minutes = duration % 60
                            
                            if hours == 0 {
                                Text("\(minutes) minutes")
                                    .tag(duration)
                            } else if minutes == 0 {
                                Text("\(hours) hours")
                                    .tag(duration)
                            } else {
                                Text("\(hours) hours \(minutes) minutes")
                                    .tag(duration)
                            }
                        }
                        
                        Text("Custom")
                    }
                }
                
                Button("Create") {
                    dismiss()
                    withAnimation {
                        completion(session)
                    }
                }
            }
            .navigationTitle("New Session")
        }
    }
}
