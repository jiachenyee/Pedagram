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
                                         grade: "1",
                                         subject: "",
                                         enrolment: 30,
                                         lessonTime: .now,
                                         duration: 15,
                                         observations: [])
    
    var enableCreateButton: Bool {
        !session.class.isEmpty && !(session.subject?.isEmpty ?? true)
    }
    
    var completion: ((Session) -> Void)
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Information") {
                    TextField("Class", text: $session.class)
                    
                    Picker("Grade", selection: $session.grade) {
                        ForEach(1..<14) { value in
                            Text("\(value)")
                                .tag("\(value)")
                        }
                    }
                    
                    TextField("Subject", text: Binding(get: {
                        session.subject ?? ""
                    }, set: { subject in
                        session.subject = subject
                    }))
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
                .disabled(!enableCreateButton)
            }
            .navigationTitle("New Session")
        }
    }
}
