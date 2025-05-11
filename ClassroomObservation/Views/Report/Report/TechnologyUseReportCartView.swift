//
//  ConfidenceReportCartView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 11/3/24.
//

import SwiftUI
import Charts

struct TechnologyUseReportCartView: View {
    
    var session: Session
    
    let options: [LocalizedStringResource] = {
        ListOfOptionsDictionarySurveyInput.options
    }()
    
    @State private var selectedTechnology = ""
    @State private var selectedTechnologyPurpose = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("How Technology is Used by Teacher")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            let technologies = session.observations.compactMap {
                $0.technologyUsedByTeacher?.stringArrayValue ?? []
            }.flatMap { $0 }.filter { !$0.isEmpty }
            
            VStack(alignment: .leading) {
                Text("\(Double(technologies.count) / Double(session.observations.count), specifier: "%.2f")")
                    .monospacedDigit()
                    .contentTransition(.numericText())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Average Number of Technologies Used")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
            }
            
            let technologiesUsed = Array(Set(technologies)).sorted()
            
            Divider()
                .padding(.vertical)
            
            Text("By App")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
            
            ReportMatrixView(rowHeaders: options,
                             columnHeaders: Array(session.sortedObservations.reversed())) {
                Picker(selection: $selectedTechnology) {
                    ForEach(technologiesUsed, id: \.self) { technology in
                        Text(technology)
                            .tag(technology)
                    }
                } label: {
                    EmptyView()
                }
                .padding(.leading, -12)
                
            } columnHeaderLabel: { observation in
                observation.time.formatted(date: .omitted, time: .shortened)
            } shouldHighlight: { row, observation in
                let observationDict = observation.howIsTheTeacherUsingTechnology?.dictValue ?? [:]
                let selections = observationDict[selectedTechnology] ?? []
                
                return selections.contains(row)
            }
            .onAppear {
                selectedTechnology = technologiesUsed.first ?? ""
            }
            
            Divider()
                .padding(.vertical)
            
            Text("By Purpose")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
            
            ReportMatrixView(rowHeaders: technologiesUsed.map { LocalizedStringResource(stringLiteral: $0) },
                             columnHeaders: Array(session.sortedObservations.reversed())) {
                Picker(selection: $selectedTechnologyPurpose) {
                    ForEach(options, id: \.key) { option in
                        Text(option)
                            .tag(option.key)
                    }
                } label: {
                    EmptyView()
                }
                .padding(.leading, -12)
                
            } columnHeaderLabel: { observation in
                observation.time.formatted(date: .omitted, time: .shortened)
            } shouldHighlight: { technology, observation in
                let observationDict = observation.howIsTheTeacherUsingTechnology?.dictValue ?? [:]
                let selections = observationDict[technology] ?? []
                
                return selections.contains(selectedTechnologyPurpose)
            }
            .onAppear {
                selectedTechnologyPurpose = options.first?.key ?? ""
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Material.ultraThick)
        .clipShape(.rect(cornerRadius: 8))
    }
}
