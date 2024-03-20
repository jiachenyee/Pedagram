//
//  ConfidenceReportCartView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 11/3/24.
//

import SwiftUI
import Charts

struct ConfidenceReportCartView: View {
    
    var question: Question
    var session: Session
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question.shorthandTitle)
                .font(.headline)
                .foregroundStyle(.secondary)
            
            let data = session.observations.compactMap {
                $0[keyPath: question.path]?.dictValue?.values.map({ $0 })
            }.flatMap { $0 }
            
            VStack(alignment: .leading) {
                Text("\(StatisticsMethods.mean.perform(on: data) ?? 0, specifier: "%.2f")")
                    .monospacedDigit()
                    .contentTransition(.numericText())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Average")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
            }
            
            HStack(spacing: 0) {
                let technologiesUsed = Array(Set(session.observations.compactMap {
                    $0[keyPath: question.path]?.dictValue?.keys.map({ $0 })
                }.flatMap { $0 }))
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Technologies")
                        .foregroundStyle(.secondary)
                        .padding(.bottom)
                    
                    ForEach(technologiesUsed, id: \.self) { technology in
                        Text(technology)
                            .font(.system(size: 16))
                            .frame(height: 24)
                    }
                }
                .padding(.trailing, 8)
                .onAppear {
                    print(technologiesUsed)
                }
                Divider()
                    .padding(.leading)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(session.observations) { observation in
                            VStack(spacing: 0) {
                                Text(observation.time, style: .time)
                                    .foregroundStyle(.secondary)
                                    .frame(width: 100)
                                    .padding(.bottom)
                                
                                let observationDict = observation[keyPath: question.path]?.dictValue ?? [:]
                                
                                ForEach(technologiesUsed, id: \.self) { technology in
                                    if let rating = observationDict[technology] {
                                        Text("\(rating)")
                                            .monospaced()
                                            .font(.system(size: 16))
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .frame(height: 24)
                                            .background(.blue.opacity(Double(rating) / 5))
                                            .foregroundStyle(rating > 2 ? .white : .black)
                                    } else {
                                        Rectangle()
                                            .fill(.clear)
                                            .frame(height: 24)
                                    }
                                }
                            }
                        }
                    }
                }
            }
//            .frame(height: 200)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
