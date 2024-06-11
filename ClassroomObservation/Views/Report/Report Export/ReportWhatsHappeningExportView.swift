//
//  ReportWhatsHappeningExportView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 20/5/24.
//

import SwiftUI

struct ReportWhatsHappeningExportView: View {
    
    @State private var selectedAnalysisMethod = StatisticsMethods.mean
    
    let targetQuestions: [Question] = [.studentsDoingIndependentWork, .studentsDoingPairWork, .studentsDoingGroupWork]
    
    var session: Session
    
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
    
    var body: some View {
        ReportWhatsHappeningGraphView(session: session)
            .padding(.bottom)
        
        VStack(alignment: .leading) {
            HStack {
                Text("Students doing…")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            
            HStack {
                Image(systemName: "square.fill")
                    .foregroundStyle(.blue)
                Text("Independent Work")
                Spacer()
                let values = session.observations.compactMap {
                    $0.studentsDoingIndependentWork?.numericValue
                }
                let output = selectedAnalysisMethod.perform(on: values) ?? 0
                
                Text("\(output)")
                    .foregroundStyle(.secondary)
                    .monospaced()
                    .contentTransition(.numericText())
            }
            .animation(.easeInOut, value: selectedAnalysisMethod)
            
            HStack {
                Image(systemName: "square.fill")
                    .foregroundStyle(.green)
                Text("Pair Work")
                Spacer()
                let values = session.observations.compactMap {
                    $0.studentsDoingPairWork?.numericValue
                }
                let output = selectedAnalysisMethod.perform(on: values) ?? 0
                
                Text("\(output)")
                    .foregroundStyle(.secondary)
                    .monospaced()
                    .contentTransition(.numericText())
            }
            .animation(.easeInOut, value: selectedAnalysisMethod)
            HStack {
                Image(systemName: "square.fill")
                    .foregroundStyle(.orange)
                Text("Group Work")
                Spacer()
                let values = session.observations.compactMap {
                    $0.studentsDoingGroupWork?.numericValue
                }
                let output = selectedAnalysisMethod.perform(on: values) ?? 0
                
                Text("\(output)")
                    .foregroundStyle(.secondary)
                    .monospaced()
                    .contentTransition(.numericText())
            }
            .animation(.easeInOut, value: selectedAnalysisMethod)
            
            Divider()
            
            HStack {
                Text("Teacher doing…")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            
            ForEach(colorAssignment.keys.map { $0 }.sorted(), id: \.self) { key in
                HStack {
                    Image(systemName: "square.fill")
                        .foregroundStyle(colorAssignment[key]!)
                        .opacity(0.4)
                    
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
        .padding()
        .background(Color.gray.opacity(0.1))
        .clipShape(.rect(cornerRadius: 8))
    }
}
