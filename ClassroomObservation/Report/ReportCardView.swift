//
//  ReportCardView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 20/12/23.
//

import SwiftUI
import Charts

struct ReportCardView: View {
    
    var question: Question
    var session: Session
    
    @State private var statisticsMethod = StatisticsMethods.mean
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question.shorthandTitle)
                .font(.headline)
                .foregroundStyle(.secondary)
            
            let data = session.observations.map {
                $0[keyPath: question.path]?.numericValue ?? 0
            }
            
            Button {
                withAnimation {
                    statisticsMethod = StatisticsMethods(rawValue: statisticsMethod.rawValue + 1) ?? StatisticsMethods(rawValue: 0)!
                }
            } label: {
                VStack(alignment: .leading) {
                    Text("\(statisticsMethod.perform(on: data) ?? 0, specifier: "%.2f")")
                        .monospacedDigit()
                        .contentTransition(.numericText())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text(statisticsMethod.description)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                }
            }
            .foregroundStyle(Color(uiColor: .label))
            
            Chart(session.observations) { observation in
                LineMark(
                    x: .value("Time", observation.time, unit: .second, calendar: .current),
                    y: .value("Value", observation[keyPath: question.path]?.numericValue ?? 0)
                )
                .foregroundStyle(.blue)
            }
            .chartXAxis(.hidden)
            .chartLegend(.hidden)
            .frame(height: 200)
        }
    }
}
