//
//  ReportWhatsHappeningView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 27/9/23.
//

import SwiftUI

struct ReportWhatsHappeningView: View {
    
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
            Text("What‘s Happening")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            ReportWhatsHappeningGraphView(session: session)
            
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
        .background(Material.ultraThick)
        .clipShape(.rect(cornerRadius: 8))
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
