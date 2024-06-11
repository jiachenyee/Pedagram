//
//  ReportStudentEngagementGraphView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 23/4/24.
//

import SwiftUI

struct ReportStudentEngagementGraphView: View {
    
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
        let steps = 5
        let graphHeight = 200.0
        
        let topPadding = 0.0
        
        HStack {
            VStack(spacing: 0) {
                ForEach((1...steps).reversed(), id: \.self) { index in
                    Text("\(index)")
                        .monospaced()
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    if index != 1 {
                        Spacer()
                    }
                }
            }
            .padding(.trailing, 4)
            .padding(.top, topPadding)
            
            ZStack {
                GeometryReader { geometry in
                    HStack(spacing: 0) {
                        let segmentWidth = geometry.size.width / CGFloat(session.observations.count - 1)
                        
                        ForEach(Array(session.sortedObservations.reversed().enumerated()), id: \.element) { (n, observation) in
                            let halfWidth = (n == 0 || n == session.observations.count - 1)
                            
                            HStack(alignment: .top, spacing: 0) {
                                if let value = observation.whatIsTheTeacherDoing?.stringValue,
                                   let color = colorAssignment[value] {
                                    Rectangle()
                                        .fill(color.opacity(0.4))
                                } else {
                                    Rectangle()
                                        .fill(.clear)
                                }
                                
                                if n != session.observations.count - 1 {
                                    Divider()
                                }
                            }
                            .frame(width: segmentWidth * (halfWidth ? 0.5 : 1))
                        }
                    }
                }
                .clipShape(.rect(cornerRadius: 8))
                
                // Grid lines
                VStack(spacing: 0) {
                    ForEach((1...steps).reversed(), id: \.self) { index in
                        Divider()
                        if index != 1 {
                            Spacer()
                        }
                    }
                }
                .padding(.top, topPadding)
                
                // Line graph
                GeometryReader { proxy in
                    let sectionGap = proxy.size.width / Double(session.observations.count - 1)
                    
                    Path { path in
                        var requiresJump = true
                        for (n, observation) in session.sortedObservations.reversed().enumerated() {
                            if let value = observation.whatIsTheLevelOfStudentEngagement?.numericValue {
                                let point = CGPoint(x: Double(sectionGap * Double(n)), y: graphHeight - (50 * Double(value - 1)))
                                
                                if requiresJump {
                                    path.move(to: point)
                                } else {
                                    path.addLine(to: point)
                                }
                                requiresJump = false
                            } else {
                                requiresJump = true
                            }
                        }
                    }
                    .stroke(.blue, lineWidth: 2)
                }
                .padding(.top, topPadding)
            }
        }
        .frame(height: graphHeight + topPadding)
        
    }
}
