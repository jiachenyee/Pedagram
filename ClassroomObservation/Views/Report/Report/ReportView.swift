//
//  ReportView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 27/9/23.
//

import SwiftUI

struct ReportView: View {
    
    var session: Session
    
    @State private var isExportablePDFViewPresented = false
    @Environment(\.dismiss) var dismiss
    
    @State private var exportedURL: URL?
    
    var isiPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if isiPad {
                        HStack {
                            ReportValueCardView(title: "Class", value: session.class)
                            ReportValueCardView(title: "Grade", value: session.grade)
                            ReportValueCardView(title: "Subject", value: session.subject ?? "N/A")
                        }
                        
                        HStack {
                            ReportValueCardView(title: "Enrolment", value: "\(session.enrolment)")
                            ReportValueCardView(title: "Observations", value: "\(session.observations.count)")
                            ReportValueCardView(title: "Observation Interval", value: "\(Int(session.recordingFrequency ?? 15))m")
                        }
                    } else {
                        HStack {
                            ReportValueCardView(title: "Class", value: session.class)
                            ReportValueCardView(title: "Grade", value: session.grade)
                        }
                        HStack {
                            ReportValueCardView(title: "Subject", value: session.subject ?? "N/A")
                            ReportValueCardView(title: "Enrolment", value: "\(session.enrolment)")
                        }
                        HStack {
                            ReportValueCardView(title: "Observations", value: "\(session.observations.count)")
                            ReportValueCardView(title: "Interval", value: "\(Int(session.recordingFrequency ?? 15))m")
                        }
                    }
                    
                    ReportCardView(question: .studentsWorkingWithTechnology, session: session)
                        .padding()
                        .background(Material.ultraThick)
                        .clipShape(.rect(cornerRadius: 8))
                    
                    ReportWhatsHappeningView(session: session)
                    
                    ReportStudentEngagementView(session: session)
                    
                    TechnologyUseReportCartView(session: session)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Questions Posed")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        let allQuestions = session.observations.flatMap {
                            $0.questionsPosedByTeacherToStudents?.stringArrayValue ?? []
                        }.filter {
                            !$0.isEmpty
                        }
                        
                        Text("\(allQuestions.count)")
                            .monospacedDigit()
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        ForEach(session.observations) { observation in
                            let time = observation.time.formatted(date: .omitted, time: .shortened)
                            let questions = observation.questionsPosedByTeacherToStudents?.stringArrayValue ?? []
                            
                            ForEach(questions, id: \.self) { question in
                                if !question.isEmpty {
                                    Divider()
                                    HStack {
                                        Text(time)
                                            .foregroundStyle(.secondary)
                                            .monospacedDigit()
                                        
                                        Text(question)
                                    }
                                    .padding(.vertical, 8)
                                }
                            }
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
                        
                        let comments = session.observations.compactMap {
                            $0.comments?.stringValue
                        }.filter {
                            !$0.isEmpty
                        }
                        
                        Text("\(comments.count)")
                            .monospacedDigit()
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        ForEach(session.observations.reversed()) { observation in
                            let time = observation.time.formatted(date: .omitted, time: .shortened)
                            let comment = observation.comments?.stringValue
                            
                            if let comment, !comment.isEmpty {
                                Divider()
                                HStack {
                                    Text(time)
                                        .foregroundStyle(.secondary)
                                        .monospacedDigit()
                                    
                                    Text(comment)
                                }
                                .padding(.vertical, 8)
                            }
                        }
                    }
                    .padding()
                    .background(Material.ultraThick)
                    .clipShape(.rect(cornerRadius: 8))
                    
                    ReportPhotosView(session: session)
                }
                .padding()
            }
            .navigationTitle("Observation Report")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    ShareLink(item: exportedURL ?? .documentsDirectory)
                        .disabled(exportedURL == nil)
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
        .task {
            exportedURL = await export()
        }
    }
    
    var colorAssignment: [String: Color] = [
        "administration": .purple,
        "whole class instruction": .indigo,
        "interacting with students": .pink
    ]
    
    var iconAssignment: [String: String] = [
        "administration": "checkmark.square",
        "whole class instruction": "rectangle.inset.filled.and.person.filled",
        "interacting with students": "bubble.left.and.text.bubble.right"
    ]
}
