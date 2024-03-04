//
//  ReportView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 27/9/23.
//

import SwiftUI

//                        studentsWorkingWithTechnology YES
//                        studentsDoingIndependentWork  YES
//                        studentsDoingPairWork         YES
//                        studentsDoingGroupWork        YES
//
//                        typeOfTaskSetByTeacher
//                        whatIsTheTeacherDoing
//
//                        howManyTimesTechnologyUsedByStudent     YES
//                        howManyTimesWasTechnologyUsedByTeacher  YES
//                        technologyUsedByStudent                 YES
//                        technologyUsedByTeacher                 YES
//
//                        teacherConfidenceInTechnology           YES
//                        questionsPosedByTeacherToStudents       YES



struct ReportView: View {
    
    var session: Session
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ReportCardView(question: .studentsWorkingWithTechnology, session: session)
                        .padding()
                        .background(Material.ultraThick)
                        .clipShape(.rect(cornerRadius: 8))
                    
                    HStack {
                        #warning("incompete implementation")
//                        VStack(spacing: 16) {
//                            ReportCardView(question: .howConfidentWereStudentsInTheUseOfEachTechnology, session: session)
//                            
//                            ReportAggregateList(session: session, question: .technologyUsedByStudent)
//                            Spacer()
//                        }
//                        .padding()
//                        .background(Material.ultraThick)
//                        .clipShape(.rect(cornerRadius: 8))
                        
                        VStack(spacing: 16) {
                            ReportCardView(question: .howManyTimesWasTechnologyUsedByTeacher, session: session)
                            
                            ReportAggregateList(session: session, question: .technologyUsedByTeacher)
                            Spacer()
                        }
                        .padding()
                        .background(Material.ultraThick)
                        .clipShape(.rect(cornerRadius: 8))
                    }
                    
                    ReportStudentsEngagementView(session: session)
                    
                    ReportCardView(question: .teacherConfidenceInTechnology, session: session)
                        .padding()
                        .background(Material.ultraThick)
                        .clipShape(.rect(cornerRadius: 8))
                    
                    VStack(alignment: .leading) {
                        Text("Questions Posed")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        let questions = session.observations.flatMap {
                            $0.questionsPosedByTeacherToStudents?.stringArrayValue ?? []
                        }
                        
                        Text("\(questions.count)")
                            .monospacedDigit()
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        ForEach(questions, id: \.self) { question in
                            Text(question)
                        }
                        .padding(.top, 8)
                    }
                    .padding()
                    .background(Material.ultraThick)
                    .clipShape(.rect(cornerRadius: 8))
                }
                .padding(.horizontal)
            }
            .navigationTitle("Observation Report")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
//        List {
//            Section("Student Engagement") {
//                ReportStudentsEngagementView(record: record)
//            }
//            
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//            
//
//            
//            Section("Technology Use") {
//                // howManyTimesTechnologyUsedByStudent
//                // howManyTimesWasTechnologyUsedByTeacher
//                Text("Times technology was used")
//                    .font(.headline)
//                    .listRowSeparator(.hidden)
//                
//                HStack {
//                    HStack {
//                        Image(systemName: "square.fill")
//                            .foregroundStyle(.blue)
//                        Text("By Teacher")
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    
//                    HStack {
//                        Image(systemName: "square.fill")
//                            .foregroundStyle(.red)
//                        Text("By Student")
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                }
//                .listRowSeparator(.hidden)
//                
//                GeometryReader { geometry in
//                    let howManyTimesTechnologyUsedByStudent = record.sortedObservations.map {
//                        $0.howManyTimesTechnologyUsedByStudent?.numericValue
//                    }
//                    
//                    let howManyTimesWasTechnologyUsedByTeacher = record.sortedObservations.map {
//                        $0.howManyTimesWasTechnologyUsedByTeacher?.numericValue
//                    }
//                    
//                    let maxValue = (howManyTimesTechnologyUsedByStudent + howManyTimesWasTechnologyUsedByTeacher).compactMap { $0 }.max() ?? 0
//                    
//                    HStack {
//                        VStack(alignment: .trailing) {
//                            Text("\(maxValue)")
//                                .frame(height: 8)
//                            ForEach(0..<5) { index in
//                                Spacer()
//                                Text("\(maxValue / 5 * (4 - index))")
//                                    .frame(height: 8)
//                            }
//                        }
//                        .monospaced()
//                        .font(.caption)
//                        .padding(.vertical, -4)
//                        
//                        GeometryReader { geometry in
//                            let yUnit = geometry.size.height / CGFloat(maxValue)
//                            
//                            let startTime = record.sortedObservations.first!.time
//                            
//                            let distance = abs(record.sortedObservations.last!.time.timeIntervalSince(startTime))
//                            
//                            let xUnit = geometry.size.width / distance
//                            
//                            Path { path in
//                                var previousValue: Int?
//                                
//                                for entry in record.sortedObservations {
//                                    let currentValue = entry.howManyTimesTechnologyUsedByStudent?.numericValue
//                                    
//                                    if let currentValue {
//                                        if previousValue == nil {
//                                            path.move(to: CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
//                                                                  y: geometry.size.height - yUnit * CGFloat(currentValue)))
//                                        } else {
//                                            path.addLine(to: CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
//                                                                     y: geometry.size.height - yUnit * CGFloat(currentValue)))
//                                        }
//                                    }
//                                    
//                                    previousValue = currentValue
//                                }
//                            }
//                            .stroke(.red, lineWidth: 3)
//                            .shadow(color: .red, radius: 10)
//                            
//                            Path { path in
//                                var previousValue: Int?
//                                
//                                for entry in record.sortedObservations {
//                                    let currentValue = entry.howManyTimesWasTechnologyUsedByTeacher?.numericValue
//                                    
//                                    if let currentValue {
//                                        if previousValue == nil {
//                                            path.move(to: CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
//                                                                  y: geometry.size.height - yUnit * CGFloat(currentValue)))
//                                        } else {
//                                            path.addLine(to: CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
//                                                                     y: geometry.size.height - yUnit * CGFloat(currentValue)))
//                                        }
//                                    }
//                                    
//                                    previousValue = currentValue
//                                }
//                            }
//                            .stroke(.blue, lineWidth: 3)
//                            .shadow(color: .blue, radius: 10)
//                            
//                            VStack(alignment: .trailing) {
//                                Divider()
//                                ForEach(0..<5) { index in
//                                    Spacer()
//                                    Divider()
//                                }
//                            }
//                            
//                            ForEach(record.sortedObservations) { entry in
//                                if let value = entry.howManyTimesTechnologyUsedByStudent?.numericValue {
//                                    let point = CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
//                                                        y: geometry.size.height - yUnit * CGFloat(value))
//                                    
//                                    Circle()
//                                        .fill(.red)
//                                        .frame(width: 16, height: 16)
//                                        .overlay {
//                                            Circle()
//                                                .stroke(.white, lineWidth: 3)
//                                        }
//                                        .position(point)
//                                        .shadow(color: .red, radius: 10)
//                                }
//                                
//                                if let value = entry.howManyTimesWasTechnologyUsedByTeacher?.numericValue {
//                                    let point = CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
//                                                        y: geometry.size.height - yUnit * CGFloat(value))
//                                    
//                                    Circle()
//                                        .fill(.blue)
//                                        .frame(width: 16, height: 16)
//                                        .overlay {
//                                            Circle()
//                                                .stroke(.white, lineWidth: 3)
//                                        }
//                                        .position(point)
//                                        .shadow(color: .blue, radius: 10)
//                                }
//                            }
//                        }
//                    }
//                }
//                .aspectRatio(1.5, contentMode: .fit)
//                .padding(.bottom)
//                .listRowSeparator(.hidden, edges: .top)
//                
//                let allStudentEntries = record.sortedObservations.flatMap {
//                    $0.technologyUsedByStudent?.stringArrayValue ?? []
//                }
//                
//                if !allStudentEntries.isEmpty {
//                    Text("By Student")
//                        .font(.headline)
//                }
//                
//                let technologyUsedByStudent = Set(allStudentEntries).sorted()
//                
//                ForEach(technologyUsedByStudent, id: \.self) { entry in
//                    HStack {
//                        let count = allStudentEntries.filter { $0 == entry }.count
//                        Text(entry)
//                        Spacer()
//                        Text("\(count)")
//                            .multilineTextAlignment(.trailing)
//                            .foregroundStyle(.secondary)
//                    }
//                }
//                
//                let allTeacherEntries = record.sortedObservations.flatMap {
//                    $0.technologyUsedByTeacher?.stringArrayValue ?? []
//                }
//                
//                if !allTeacherEntries.isEmpty {
//                    Text("By Teacher")
//                        .font(.headline)
//                }
//                
//                let technologyUsedByTeacher = Set(allTeacherEntries).sorted()
//                
//                ForEach(technologyUsedByTeacher, id: \.self) { entry in
//                    HStack {
//                        let count = allTeacherEntries.filter { $0 == entry }.count
//                        Text(entry)
//                        Spacer()
//                        Text("\(count)")
//                            .multilineTextAlignment(.trailing)
//                            .foregroundStyle(.secondary)
//                    }
//                }
//            }
//            
//            Section("Teacher Confidence in Technology") {
//                GeometryReader { geometry in
//                    let maxTeacherConfidenceInTechnology = 10
//                    
//                    HStack {
//                        VStack(alignment: .trailing) {
//                            Text("\(maxTeacherConfidenceInTechnology)")
//                                .frame(height: 8)
//                            ForEach(0..<10) { index in
//                                Spacer()
//                                Text("\(maxTeacherConfidenceInTechnology - index - 1)")
//                                    .frame(height: 8)
//                            }
//                        }
//                        .monospaced()
//                        .font(.caption)
//                        .padding(.vertical, -4)
//                        
//                        GeometryReader { geometry in
//                            let yUnit = geometry.size.height / CGFloat(maxTeacherConfidenceInTechnology)
//                            
//                            let startTime = record.sortedObservations.first!.time
//                            
//                            let distance = abs(record.sortedObservations.last!.time.timeIntervalSince(startTime))
//                            
//                            let xUnit = geometry.size.width / distance
//                            
//                            Path { path in
//                                var previousValue: Int?
//                                
//                                for entry in record.sortedObservations {
//                                    let currentValue = entry.teacherConfidenceInTechnology?.numericValue
//                                    
//                                    if let currentValue {
//                                        if previousValue == nil {
//                                            path.move(to: CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
//                                                                  y: geometry.size.height - yUnit * CGFloat(currentValue)))
//                                        } else {
//                                            path.addLine(to: CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
//                                                                     y: geometry.size.height - yUnit * CGFloat(currentValue)))
//                                        }
//                                    }
//                                    
//                                    previousValue = currentValue
//                                }
//                            }
//                            .stroke(.red, lineWidth: 3)
//                            .shadow(color: .red, radius: 10)
//                            
//                            VStack(alignment: .trailing) {
//                                Divider()
//                                ForEach(0..<10) { index in
//                                    Spacer()
//                                    Divider()
//                                }
//                            }
//                            
//                            ForEach(record.sortedObservations) { entry in
//                                if let currentValue = entry.teacherConfidenceInTechnology?.numericValue {
//                                    let point = CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
//                                                        y: geometry.size.height - yUnit * CGFloat(currentValue))
//                                    
//                                    Circle()
//                                        .fill(.red)
//                                        .frame(width: 16, height: 16)
//                                        .overlay {
//                                            Circle()
//                                                .stroke(.white, lineWidth: 3)
//                                        }
//                                        .position(point)
//                                        .shadow(color: .red, radius: 10)
//                                }
//                            }
//                        }
//                    }
//                }
//                .aspectRatio(1.5, contentMode: .fit)
//                .padding(.vertical)
//                .listRowSeparator(.hidden, edges: .top)
//            }
//            
//            Section("Questions Posed") {
//                ForEach(record.sortedObservations) { entry in
//                    let questions = entry.questionsPosedByTeacherToStudents?.stringArrayValue ?? []
//                    
//                    ForEach(questions, id: \.self) { question in
//                        Text(question)
//                    }
//                }
//            }
//        }
    }
}
