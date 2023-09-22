//
//  ReportView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 27/9/23.
//

import SwiftUI

struct ReportView: View {
    
    var observation: Observation
    
    var body: some View {
        NavigationStack {
            List {
                Section("Class Information") {
                    HStack {
                        Text("Class")
                        Spacer()
                        Text(observation.class)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Grade")
                        Spacer()
                        Text(observation.grade)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Enrolment")
                        Spacer()
                        Text("\(observation.enrolment)")
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Lesson Date/Time")
                        Spacer()
                        Text(observation.lessonTime.formatted(date: .abbreviated, time: .shortened))
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Duration")
                        Spacer()
                        Text("\(Int(observation.duration / 60)) minutes")
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section("Student Engagement") {
                    ReportStudentsEngagementView(observation: observation)
                }
                
//                        studentsWorkingWithTechnology
//                        studentsDoingIndependentWork
//                        studentsDoingPairWork
//                        studentsDoingGroupWork
//
//                        typeOfTaskSetByTeacher
//                        whatIsTheTeacherDoing
//
//                        howManyTimesTechnologyUsedByStudent
//                        howManyTimesWasTechnologyUsedByTeacher
//                        technologyUsedByStudent
//                        technologyUsedByTeacher
//
//                        teacherConfidenceInTechnology
                
//                        questionsPosedByTeacherToStudents
                
                Section("Technology Use") {
                    // howManyTimesTechnologyUsedByStudent
                    // howManyTimesWasTechnologyUsedByTeacher
                    Text("Times technology was used")
                        .font(.headline)
                        .listRowSeparator(.hidden)
                    
                    HStack {
                        HStack {
                            Image(systemName: "square.fill")
                                .foregroundStyle(.blue)
                            Text("By Teacher")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            Image(systemName: "square.fill")
                                .foregroundStyle(.red)
                            Text("By Student")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .listRowSeparator(.hidden)
                    
                    GeometryReader { geometry in
                        let howManyTimesTechnologyUsedByStudent = observation.entries.map {
                            $0.howManyTimesTechnologyUsedByStudent?.numericValue
                        }
                        
                        let howManyTimesWasTechnologyUsedByTeacher = observation.entries.map {
                            $0.howManyTimesWasTechnologyUsedByTeacher?.numericValue
                        }
                        
                        let maxValue = (howManyTimesTechnologyUsedByStudent + howManyTimesWasTechnologyUsedByTeacher).compactMap { $0 }.max() ?? 0
                        
                        HStack {
                            VStack(alignment: .trailing) {
                                Text("\(maxValue)")
                                    .frame(height: 8)
                                ForEach(0..<5) { index in
                                    Spacer()
                                    Text("\(maxValue / 5 * (4 - index))")
                                        .frame(height: 8)
                                }
                            }
                            .monospaced()
                            .font(.caption)
                            .padding(.vertical, -4)
                            
                            GeometryReader { geometry in
                                let yUnit = geometry.size.height / CGFloat(maxValue)
                                
                                let startTime = observation.entries.first!.time
                                
                                let distance = abs(observation.entries.last!.time.timeIntervalSince(startTime))
                                
                                let xUnit = geometry.size.width / distance
                                
                                Path { path in
                                    var previousValue: Int?
                                    
                                    for entry in observation.entries {
                                        let currentValue = entry.howManyTimesTechnologyUsedByStudent?.numericValue
                                        
                                        if let currentValue {
                                            if previousValue == nil {
                                                path.move(to: CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
                                                                      y: geometry.size.height - yUnit * CGFloat(currentValue)))
                                            } else {
                                                path.addLine(to: CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
                                                                         y: geometry.size.height - yUnit * CGFloat(currentValue)))
                                            }
                                        }
                                        
                                        previousValue = currentValue
                                    }
                                }
                                .stroke(.red, lineWidth: 3)
                                .shadow(color: .red, radius: 10)
                                
                                Path { path in
                                    var previousValue: Int?
                                    
                                    for entry in observation.entries {
                                        let currentValue = entry.howManyTimesWasTechnologyUsedByTeacher?.numericValue
                                        
                                        if let currentValue {
                                            if previousValue == nil {
                                                path.move(to: CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
                                                                      y: geometry.size.height - yUnit * CGFloat(currentValue)))
                                            } else {
                                                path.addLine(to: CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
                                                                         y: geometry.size.height - yUnit * CGFloat(currentValue)))
                                            }
                                        }
                                        
                                        previousValue = currentValue
                                    }
                                }
                                .stroke(.blue, lineWidth: 3)
                                .shadow(color: .blue, radius: 10)
                                
                                VStack(alignment: .trailing) {
                                    Divider()
                                    ForEach(0..<5) { index in
                                        Spacer()
                                        Divider()
                                    }
                                }
                                
                                ForEach(observation.entries) { entry in
                                    if let value = entry.howManyTimesTechnologyUsedByStudent?.numericValue {
                                        let point = CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
                                                            y: geometry.size.height - yUnit * CGFloat(value))
                                        
                                        Circle()
                                            .fill(.red)
                                            .frame(width: 16, height: 16)
                                            .overlay {
                                                Circle()
                                                    .stroke(.white, lineWidth: 3)
                                            }
                                            .position(point)
                                            .shadow(color: .red, radius: 10)
                                    }
                                    
                                    if let value = entry.howManyTimesWasTechnologyUsedByTeacher?.numericValue {
                                        let point = CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
                                                            y: geometry.size.height - yUnit * CGFloat(value))
                                        
                                        Circle()
                                            .fill(.blue)
                                            .frame(width: 16, height: 16)
                                            .overlay {
                                                Circle()
                                                    .stroke(.white, lineWidth: 3)
                                            }
                                            .position(point)
                                            .shadow(color: .blue, radius: 10)
                                    }
                                }
                            }
                        }
                    }
                    .aspectRatio(1.5, contentMode: .fit)
                    .padding(.bottom)
                    .listRowSeparator(.hidden, edges: .top)
                    
                    let allStudentEntries = observation.entries.flatMap {
                        $0.technologyUsedByStudent?.stringArrayValue ?? []
                    }
                    
                    if !allStudentEntries.isEmpty {
                        Text("By Student")
                            .font(.headline)
                    }
                    
                    let technologyUsedByStudent = Set(allStudentEntries).sorted()
                    
                    ForEach(technologyUsedByStudent, id: \.self) { entry in
                        HStack {
                            let count = allStudentEntries.filter { $0 == entry }.count
                            Text(entry)
                            Spacer()
                            Text("\(count)")
                                .multilineTextAlignment(.trailing)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    let allTeacherEntries = observation.entries.flatMap {
                        $0.technologyUsedByTeacher?.stringArrayValue ?? []
                    }
                    
                    if !allTeacherEntries.isEmpty {
                        Text("By Teacher")
                            .font(.headline)
                    }
                    
                    let technologyUsedByTeacher = Set(allTeacherEntries).sorted()
                    
                    ForEach(technologyUsedByTeacher, id: \.self) { entry in
                        HStack {
                            let count = allTeacherEntries.filter { $0 == entry }.count
                            Text(entry)
                            Spacer()
                            Text("\(count)")
                                .multilineTextAlignment(.trailing)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                Section("Teacher Confidence in Technology") {
                    GeometryReader { geometry in
                        let maxTeacherConfidenceInTechnology = 10
                        
                        HStack {
                            VStack(alignment: .trailing) {
                                Text("\(maxTeacherConfidenceInTechnology)")
                                    .frame(height: 8)
                                ForEach(0..<10) { index in
                                    Spacer()
                                    Text("\(maxTeacherConfidenceInTechnology - index - 1)")
                                        .frame(height: 8)
                                }
                            }
                            .monospaced()
                            .font(.caption)
                            .padding(.vertical, -4)
                            
                            GeometryReader { geometry in
                                let yUnit = geometry.size.height / CGFloat(maxTeacherConfidenceInTechnology)
                                
                                let startTime = observation.entries.first!.time
                                
                                let distance = abs(observation.entries.last!.time.timeIntervalSince(startTime))
                                
                                let xUnit = geometry.size.width / distance
                                
                                Path { path in
                                    var previousValue: Int?
                                    
                                    for entry in observation.entries {
                                        let currentValue = entry.teacherConfidenceInTechnology?.numericValue
                                        
                                        if let currentValue {
                                            if previousValue == nil {
                                                path.move(to: CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
                                                                      y: geometry.size.height - yUnit * CGFloat(currentValue)))
                                            } else {
                                                path.addLine(to: CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
                                                                         y: geometry.size.height - yUnit * CGFloat(currentValue)))
                                            }
                                        }
                                        
                                        previousValue = currentValue
                                    }
                                }
                                .stroke(.red, lineWidth: 3)
                                .shadow(color: .red, radius: 10)
                                
                                VStack(alignment: .trailing) {
                                    Divider()
                                    ForEach(0..<10) { index in
                                        Spacer()
                                        Divider()
                                    }
                                }
                                
                                ForEach(observation.entries) { entry in
                                    if let currentValue = entry.teacherConfidenceInTechnology?.numericValue {
                                        let point = CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
                                                            y: geometry.size.height - yUnit * CGFloat(currentValue))
                                        
                                        Circle()
                                            .fill(.red)
                                            .frame(width: 16, height: 16)
                                            .overlay {
                                                Circle()
                                                    .stroke(.white, lineWidth: 3)
                                            }
                                            .position(point)
                                            .shadow(color: .red, radius: 10)
                                    }
                                }
                            }
                        }
                    }
                    .aspectRatio(1.5, contentMode: .fit)
                    .padding(.vertical)
                    .listRowSeparator(.hidden, edges: .top)
                }
                
                Section("Questions Posed") {
                    ForEach(observation.entries) { entry in
                        let questions = entry.questionsPosedByTeacherToStudents?.stringArrayValue ?? []
                        
                        ForEach(questions, id: \.self) { question in
                            Text(question)
                        }
                    }
                }
            }
            .navigationTitle("Observation Report")
        }
    }
}
