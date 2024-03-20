//
//  ReportView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 27/9/23.
//

import SwiftUI

//  case studentsWorkingWithTechnology YES
//  case studentsDoingIndependentWork YES
//  case studentsDoingPairWork YES
//  case studentsDoingGroupWork YES
//
//  case technologyUsedByStudent YES
//  case howConfidentWereStudentsInTheUseOfEachTechnology YES
//  case typeOfTaskSetByTeacher
//
//  case whatIsTheTeacherDoing
//  case technologyUsedByTeacher YES
//  case teacherConfidenceInTechnology YES

//  case questionsPosedByTeacherToStudents YES
//  case comments YES
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
                    
                    ReportStudentsEngagementView(session: session)
                    
                    // Visualize what the teacher is doing
                    
                    ConfidenceReportCartView(question: .howConfidentWereStudentsInTheUseOfEachTechnology, session: session)
                        .padding()
                        .background(Material.ultraThick)
                        .clipShape(.rect(cornerRadius: 8))
                    
                    ConfidenceReportCartView(question: .teacherConfidenceInTechnology, session: session)
                        .padding()
                        .background(Material.ultraThick)
                        .clipShape(.rect(cornerRadius: 8))
                    
                    VStack(alignment: .leading) {
                        Text("What‘s going on")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 0) {
                            VStack {
                                Text("Time")
                                    .foregroundStyle(.secondary)
                                    .padding(.bottom)
                                ForEach(session.observations) { observation in
                                    Text(observation.time, style: .time)
                                        .frame(height: 24)
                                }
                            }
                            .padding(.trailing)
                            
                            Divider()
                            
                            ScrollView(.horizontal) {
                                HStack(spacing: 0) {
                                    VStack {
                                        Text("Task set by teacher")
                                            .padding(.horizontal)
                                            .foregroundStyle(.secondary)
                                            .padding(.bottom)
                                        ForEach(session.observations) { observation in
                                            if let value = observation.typeOfTaskSetByTeacher?.stringValue?.capitalized {
                                                Text(value)
                                                    .font(.system(size: 18))
                                                    .padding(.horizontal)
                                                    .frame(height: 24)
                                            } else {
                                                Rectangle()
                                                    .fill(.clear)
                                                    .frame(height: 24)
                                            }
                                        }
                                    }
                                    VStack {
                                        Text("What is the teacher doing")
                                            .padding(.horizontal)
                                            .foregroundStyle(.secondary)
                                            .padding(.bottom)
                                        ForEach(session.observations) { observation in
                                            if let value = observation.whatIsTheTeacherDoing?.stringValue?.capitalized {
                                                Text(value)
                                                    .font(.system(size: 18))
                                                    .padding(.horizontal)
                                                    .frame(height: 24)
                                            } else {
                                                Rectangle()
                                                    .fill(.clear)
                                                    .frame(height: 24)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Material.ultraThick)
                    .clipShape(.rect(cornerRadius: 8))
                    
                    VStack(alignment: .leading, spacing: 0) {
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
                            Divider()
                            Text(question)
                                .padding(.vertical)
                        }
                    }
                    .padding()
                    .background(Material.ultraThick)
                    .clipShape(.rect(cornerRadius: 8))
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Comments")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        let comments = session.observations.flatMap {
                            $0.comments?.stringArrayValue ?? []
                        }
                        
                        Text("\(comments.count)")
                            .monospacedDigit()
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        ForEach(comments, id: \.self) { comment in
                            Divider()
                            Text(comment)
                                .padding(.vertical)
                        }
                    }
                    .padding()
                    .background(Material.ultraThick)
                    .clipShape(.rect(cornerRadius: 8))
                }
                .padding()
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
    }
}
