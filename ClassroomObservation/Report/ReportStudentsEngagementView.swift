//
//  ReportStudentsEngagementView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 27/9/23.
//

import SwiftUI
import Charts

struct StudentsEngagementReportData: Identifiable {
    
    var id: String
    
    var question: Question
    var time: Date
    var value: Int?
}

struct ReportStudentsEngagementView: View {
    
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
        VStack(alignment: .leading) {
            Text("Student Engagement")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            let maxValue = getHighestValue(in: session.observations.max {
                getHighestValue(in: $0) < getHighestValue(in: $1)
            } ?? .init())
            
            let upperbound = Int(ceil(Double(maxValue) / 10) * 10)
            let steps = upperbound / 10
            let graphHeight = 200.0
            let incrementHeight = graphHeight / Double(upperbound)
            
            let topPadding = 48.0
            
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
                    Grid(alignment: .leading, horizontalSpacing: 0, verticalSpacing: 0) {
                        GridRow {
                            ForEach(Array(session.sortedObservations.reversed().enumerated()), id: \.element) { (n, observation) in
                                let halfWidth = (n == 0 || n == session.observations.count - 1)
                                
                                ZStack(alignment: .top) {
                                    if let value = observation.whatIsTheTeacherDoing?.stringValue,
                                       let color = colorAssignment[value] {
                                        Rectangle()
                                            .fill(color)
                                            .opacity(0.2)
                                    } else {
                                        Rectangle()
                                            .fill(.clear)
                                            .opacity(0.2)
                                    }
                                    
                                    if let value = observation.whatIsTheTeacherDoing?.stringValue,
                                       let color = colorAssignment[value] {
                                        Image(systemName: iconAssignment[value]!)
                                            .font(.system(size: 21))
                                            .foregroundStyle(color)
                                            .padding(.top, 8)
                                    }
                                }
                                .gridCellColumns(halfWidth ? 1 : 2)
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
            
            HStack {
                Text("Students doing…")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
                Picker(selection: $selectedAnalysisMethod) {
                    ForEach(StatisticsMethods.allCases, id: \.self) { statisticMethod in
                        Text(statisticMethod.description)
                    }
                } label: {
                    EmptyView()
                }
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
                        .opacity(0.2)
                    
                    Image(systemName: iconAssignment[key]!)
                        .foregroundStyle(colorAssignment[key]!)
                        .font(.system(size: 18))
                        .frame(width: 32, alignment: .leading)
                    
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
        .background(Material.ultraThick)
        .clipShape(.rect(cornerRadius: 8))
    }
    
    func getHighestValue(in observation: Observation) -> Int {
        max(observation.studentsDoingGroupWork?.numericValue ?? 0, observation.studentsDoingPairWork?.numericValue ?? 0, observation.studentsDoingIndependentWork?.numericValue ?? 0)
    }
}

enum StatisticsMethods: Int, CaseIterable, Hashable {
    case mean
    case median
    case mode
    case stdev
    
    var description: String {
        switch self {
        case .mean:
            return "Average"
        case .median:
            return "Median"
        case .mode:
            return "Mode"
        case .stdev:
            return "Standard Deviation"
        }
    }
    
    func perform(on values: [Int]) -> Double? {
        guard !values.isEmpty else { return nil }
        
        switch self {
        case .mean:
            let sum = values.reduce(0, +)
            return Double(sum) / Double(values.count)
            
        case .median:
            let sortedValues = values.sorted()
            let count = sortedValues.count
            if count % 2 == 0 {
                let midIndex = count / 2
                return Double(sortedValues[midIndex - 1] + sortedValues[midIndex]) / 2.0
            } else {
                return Double(sortedValues[count / 2])
            }
            
        case .mode:
            var frequencyDict = [Int: Int]()
            for value in values {
                frequencyDict[value, default: 0] += 1
            }
            let maxFrequency = frequencyDict.values.max()
            let modes = frequencyDict.filter { $1 == maxFrequency }.keys
            return modes.isEmpty ? nil : Double(modes.reduce(0, +) / modes.count)
            
        case .stdev:
            let mean = Self.mean.perform(on: values)!
            let variance = values.reduce(0.0) { sum, value in
                sum + pow(Double(value) - mean, 2)
            } / Double(values.count)
            return sqrt(variance)
        }
    }
}
