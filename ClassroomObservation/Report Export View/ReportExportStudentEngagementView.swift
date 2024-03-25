//
//  ReportExportStudentEngagementView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 26/3/24.
//

import SwiftUI

struct ReportExportStudentEngagementView: View {
    
    var session: Session
    
    var body: some View {
        GridRow {
            VStack(alignment: .leading) {
                Text("Student Engagement")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 16, weight: .bold))
                
                Text("Understand what the student is doing (independent work, pair work, or group work) compared to what the teacher is doing.")
                    .font(.system(size: 11))
            }
            .gridCellColumns(3)
            .padding(.top)
        }
        
        GridRow {
            ReportStudentEngagementGraphView(session: session)
                .gridCellColumns(3)
        }
        
        GridRow {
            Grid {
                GridRow {
                    Text("Student doing…")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 14, weight: .semibold))
                        .gridCellColumns(3)
                        .padding(.bottom, 8)
                    
                    Text("Average")
                        .gridCellColumns(1)
                    
                    Text("Median")
                        .gridCellColumns(1)
                    
                    Text("Mode")
                        .gridCellColumns(1)
                    
                    Text("Std. Dev.")
                        .gridCellColumns(1)
                }
                
                GridRow {
                    HStack {
                        Image(systemName: "square.fill")
                            .foregroundStyle(.blue)
                        Text("Independent Work")
                        Spacer()
                    }
                    .gridCellColumns(3)
                    
                    ForEach(StatisticsMethods.allCases, id: \.rawValue) { method in
                        let values = session.observations.compactMap {
                            $0.studentsDoingIndependentWork?.numericValue
                        }
                        let output = method.perform(on: values) ?? 0
                        Text("\(output, specifier: "%.2f")")
                            .monospaced()
                            .gridCellColumns(1)
                    }
                }
                GridRow {
                    HStack {
                        Image(systemName: "square.fill")
                            .foregroundStyle(.green)
                        Text("Pair Work")
                        Spacer()
                    }
                    .gridCellColumns(3)
                    
                    ForEach(StatisticsMethods.allCases, id: \.rawValue) { method in
                        let values = session.observations.compactMap {
                            $0.studentsDoingPairWork?.numericValue
                        }
                        let output = method.perform(on: values) ?? 0
                        Text("\(output, specifier: "%.2f")")
                            .monospaced()
                            .gridCellColumns(1)
                    }
                }
                GridRow {
                    HStack {
                        Image(systemName: "square.fill")
                            .foregroundStyle(.orange)
                        Text("Group Work")
                        Spacer()
                    }
                    .gridCellColumns(3)
                    
                    ForEach(StatisticsMethods.allCases, id: \.rawValue) { method in
                        let values = session.observations.compactMap {
                            $0.studentsDoingGroupWork?.numericValue
                        }
                        let output = method.perform(on: values) ?? 0
                        Text("\(output, specifier: "%.2f")")
                            .monospaced()
                            .gridCellColumns(1)
                    }
                }
            }
            .font(.system(size: 11))
            .padding()
            .background(Color.gray.opacity(0.1))
            .clipShape(.rect(cornerRadius: 8))
            .gridCellColumns(3)
        }
        
        GridRow {
            VStack {
                HStack {
                    Text("Teacher doing…")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.bottom, 8)
                    Spacer()
                    Text("Count")
                        .gridCellColumns(1)
                }
                
                let colorAssignment: [String: Color] = [
                    "administration": .purple,
                    "whole class instruction": .indigo,
                    "interacting with students": .pink
                ]
                
                let iconAssignment: [String: String] = [
                    "administration": "checkmark.square",
                    "whole class instruction": "rectangle.inset.filled.and.person.filled",
                    "interacting with students": "bubble.left.and.text.bubble.right"
                ]
                
                ForEach(colorAssignment.keys.map { $0 }.sorted(), id: \.self) { key in
                    HStack {
                        Image(systemName: iconAssignment[key]!)
                            .foregroundStyle(colorAssignment[key]!)
                            .frame(width: 24, alignment: .leading)
                        
                        Text(key.capitalized)
                        
                        Spacer()
                        
                        let count = session.observations.filter {
                            $0.whatIsTheTeacherDoing?.stringValue == key
                        }.count
                        
                        Text("\(count)")
                            .foregroundStyle(.secondary)
                            .monospaced()
                    }
                }
            }
            .font(.system(size: 11))
            .padding()
            .background(Color.gray.opacity(0.1))
            .clipShape(.rect(cornerRadius: 8))
            .gridCellColumns(3)
        }
    }
}
