//
//  ReportWhatsHappeningGraphView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 26/3/24.
//

import SwiftUI

struct ReportWhatsHappeningGraphView: View {
    
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
        let maxValue = getHighestValue(in: session.observations.max {
            getHighestValue(in: $0) < getHighestValue(in: $1)
        } ?? .init())
        
        let upperbound = Int(ceil(Double(maxValue) / 10) * 10)
        let steps = upperbound / 10
        let graphHeight = 200.0
        let incrementHeight = graphHeight / Double(upperbound)
        
        let topPadding = 0.0
        
        HStack {
            VStack(spacing: 0) {
                ForEach((0...steps).reversed(), id: \.self) { index in
                    Text("\(index * 10)")
                        .monospaced()
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    if index != 0 {
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
                    ForEach((0...steps).reversed(), id: \.self) { index in
                        Divider()
                        if index != 0 {
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
                            if let value = observation.studentsDoingIndependentWork?.numericValue {
                                let point = CGPoint(x: Double(sectionGap * Double(n)), y: graphHeight - incrementHeight * Double(value))
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
                    
                    Path { path in
                        var requiresJump = true
                        for (n, observation) in session.sortedObservations.reversed().enumerated() {
                            if let value = observation.studentsDoingPairWork?.numericValue {
                                let point = CGPoint(x: Double(sectionGap * Double(n)), y: graphHeight - incrementHeight * Double(value))
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
                    .stroke(.green, lineWidth: 2)
                    
                    Path { path in
                        var requiresJump = true
                        for (n, observation) in session.sortedObservations.reversed().enumerated() {
                            if let value = observation.studentsDoingGroupWork?.numericValue {
                                let point = CGPoint(x: Double(sectionGap * Double(n)), y: graphHeight - incrementHeight * Double(value))
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
                    .stroke(.orange, lineWidth: 2)
                }
                .padding(.top, topPadding)
            }
        }
        .frame(height: graphHeight + topPadding)

    }
    
    func getHighestValue(in observation: Observation) -> Int {
        max(observation.studentsDoingGroupWork?.numericValue ?? 0, observation.studentsDoingPairWork?.numericValue ?? 0, observation.studentsDoingIndependentWork?.numericValue ?? 0)
    }
}
