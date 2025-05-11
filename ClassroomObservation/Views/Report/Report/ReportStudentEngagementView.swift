//
//  ReportStudentEngagementView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 23/4/24.
//

import SwiftUI

struct ReportStudentEngagementView: View {
    
    @State private var selectedAnalysisMethod = StatisticsMethods.mean
    
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
        VStack(alignment: .leading) {
            Text("Student Engagement")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            Text("On a scale of 1 to 5.")
                .foregroundStyle(.secondary)
            
            ReportStudentEngagementGraphView(session: session)
            
            let commentCount = session.observations.reduce(0) { partialResult, observation in
                if let comment = observation.whatIsTheLevelOfStudentEngagement?.scaleComments?.comments, !comment.isEmpty {
                    return partialResult + 1
                } else {
                    return partialResult
                }
            }
            
            HStack {
                Text("Comments (\(commentCount))")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            
            ForEach(session.observations.reversed()) { observation in
                if let comment = observation.whatIsTheLevelOfStudentEngagement?.scaleComments?.comments, !comment.isEmpty {
                    let time = observation.time.formatted(date: .omitted, time: .shortened)
                    HStack {
                        Text(time)
                            .foregroundStyle(.secondary)
                            .monospacedDigit()
                        Text(comment)
                    }
                }
            }
            
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
                    
                    Text(LocalizedStringKey(key))
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
        .background(Material.ultraThick)
        .clipShape(.rect(cornerRadius: 8))
    }
}
