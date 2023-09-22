//
//  ReportStudentsEngagementView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 27/9/23.
//

import SwiftUI

struct ReportStudentsEngagementView: View {
    
    @State private var selectedAnalysisMethod = StatisticsMethods.mean
    
    var observation: Observation
    
    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader { geometry in
                HStack {
                    VStack(alignment: .trailing) {
                        Text("\(observation.enrolment)")
                            .frame(height: 8)
                        ForEach(0..<5) { index in
                            Spacer()
                            Text("\(observation.enrolment / 5 * (4 - index))")
                                .frame(height: 8)
                        }
                    }
                    .monospaced()
                    .font(.caption)
                    .padding(.vertical, -4)
                    
                    GeometryReader { geometry in
                        let yUnit = geometry.size.height / CGFloat(observation.enrolment)
                        
                        let startTime = observation.entries.first!.time
                        
                        let distance = abs(observation.entries.last!.time.timeIntervalSince(startTime))
                        
                        let xUnit = geometry.size.width / distance
                        
                        Path { path in
                            var previousValue: Int?
                            
                            for entry in observation.entries {
                                let currentValue = entry.studentsWorkingWithTechnology?.numericValue
                                
                                if let currentValue {
                                    if previousValue == nil {
                                        path.move(to: CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
                                                              y: geometry.size.height - yUnit * CGFloat(currentValue)))
                                    } else {
                                        path.addLine(to: CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
                                                                 y: geometry.size.height - yUnit * CGFloat(currentValue)))
                                    }
                                }
                                
                                previousValue = currentValue
                            }
                        }
                        .stroke(.red, lineWidth: 3)
                        .shadow(color: .red, radius: 10)
                        
                        Path { path in
                            var previousValue: Int?
                            
                            for entry in observation.entries {
                                let currentValue = entry.studentsDoingIndependentWork?.numericValue
                                
                                if let currentValue {
                                    if previousValue == nil {
                                        path.move(to: CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
                                                              y: geometry.size.height - yUnit * CGFloat(currentValue)))
                                    } else {
                                        path.addLine(to: CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
                                                                 y: geometry.size.height - yUnit * CGFloat(currentValue)))
                                    }
                                }
                                
                                previousValue = currentValue
                            }
                        }
                        .stroke(.blue, lineWidth: 3)
                        .shadow(color: .blue, radius: 10)
                        
                        Path { path in
                            var previousValue: Int?
                            
                            for entry in observation.entries {
                                let currentValue = entry.studentsDoingPairWork?.numericValue
                                
                                if let currentValue {
                                    if previousValue == nil {
                                        path.move(to: CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
                                                              y: geometry.size.height - yUnit * CGFloat(currentValue)))
                                    } else {
                                        path.addLine(to: CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
                                                                 y: geometry.size.height - yUnit * CGFloat(currentValue)))
                                    }
                                }
                                
                                previousValue = currentValue
                            }
                        }
                        .stroke(.teal, lineWidth: 3)
                        .shadow(color: .teal, radius: 10)
                        
                        Path { path in
                            var previousValue: Int?
                            
                            for entry in observation.entries {
                                let currentValue = entry.studentsDoingGroupWork?.numericValue
                                
                                if let currentValue {
                                    if previousValue == nil {
                                        path.move(to: CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
                                                              y: geometry.size.height - yUnit * CGFloat(currentValue)))
                                    } else {
                                        path.addLine(to: CGPoint(x: xUnit * abs(startTime.timeIntervalSince(entry.time)),
                                                                 y: geometry.size.height - yUnit * CGFloat(currentValue)))
                                    }
                                }
                                
                                previousValue = currentValue
                            }
                        }
                        .stroke(.green, lineWidth: 3)
                        .shadow(color: .green, radius: 10)
                        
                        VStack(alignment: .trailing) {
                            Divider()
                            ForEach(0..<5) { index in
                                Spacer()
                                Divider()
                            }
                        }
                    }
                }
            }
            .aspectRatio(1.5, contentMode: .fit)
            .padding(.bottom)
        }
        .padding(.vertical)
        
        Picker(selection: $selectedAnalysisMethod) {
            ForEach(StatisticsMethods.allCases, id: \.self) { statisticMethod in
                Text(statisticMethod.description)
            }
        } label: {
            Text("Statistics")
        }
        .pickerStyle(.segmented)
        .listRowSeparator(.hidden)
        
            HStack {
                Image(systemName: "square.fill")
                    .foregroundStyle(.red)
                Text("Students Working With Technology")
                Spacer()
                
                let values = observation.entries.compactMap {
                    $0.studentsWorkingWithTechnology?.numericValue
                }
                let output = selectedAnalysisMethod.perform(on: values) ?? 0
                
                Text("\(output)")
                    .foregroundStyle(.secondary)
                    .monospaced()
                    .contentTransition(.numericText())
            }
            .animation(.easeInOut, value: selectedAnalysisMethod)
            
            Text("Students doing…")
                .frame(maxWidth: .infinity, alignment: .leading)
                .listRowSeparator(.hidden, edges: .bottom)
        
            HStack {
                Image(systemName: "square.fill")
                    .foregroundStyle(.green)
                Text("Group Work")
                Spacer()
                let values = observation.entries.compactMap {
                    $0.studentsDoingGroupWork?.numericValue
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
                    .foregroundStyle(.teal)
                Text("Pair Work")
                Spacer()
                let values = observation.entries.compactMap {
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
                    .foregroundStyle(.blue)
                Text("Independent Work")
                Spacer()
                let values = observation.entries.compactMap {
                    $0.studentsDoingIndependentWork?.numericValue
                }
                let output = selectedAnalysisMethod.perform(on: values) ?? 0
                
                Text("\(output)")
                    .foregroundStyle(.secondary)
                    .monospaced()
                    .contentTransition(.numericText())
            }
            .animation(.easeInOut, value: selectedAnalysisMethod)
    }
}

enum StatisticsMethods: CaseIterable, Hashable {
    case mean
    case median
    case mode
    case stdev
    
    var description: String {
        switch self {
        case .mean:
            return "Mean"
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
