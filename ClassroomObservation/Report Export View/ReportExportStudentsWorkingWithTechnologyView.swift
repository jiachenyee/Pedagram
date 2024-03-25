//
//  ReportExportStudentsWorkingWithTechnologyView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 26/3/24.
//

import SwiftUI
import Charts

struct ReportExportStudentsWorkingWithTechnologyView: View {
    
    var session: Session
    
    var body: some View {
        GridRow {
            Text("Students working with technology")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 16, weight: .bold))
                .gridCellColumns(3)
                .padding(.top)
        }
        
        let data = session.observations.map {
            $0.studentsWorkingWithTechnology?.numericValue ?? 0
        }
        
        GridRow {
            VStack(alignment: .leading) {
                Chart(session.observations) { observation in
                    LineMark(
                        x: .value("Time", observation.time, unit: .second, calendar: .current),
                        y: .value("Value", observation.studentsWorkingWithTechnology?.numericValue ?? 0)
                    )
                    .foregroundStyle(.blue)
                }
                .chartLegend(.hidden)
                .font(.system(size: 11))
            }
            .padding()
            .frame(height: 67 * 4 + 8 * 3)
            .background(Color.gray.opacity(0.1))
            .clipShape(.rect(cornerRadius: 8))
            .gridCellColumns(2)
            
            VStack {
                ForEach(StatisticsMethods.allCases, id: \.rawValue) { method in
                    VStack(alignment: .leading) {
                        Text("\(method.perform(on: data) ?? 0, specifier: "%.2f")")
                            .monospacedDigit()
                            .font(.system(size: 18, weight: .bold))
                        
                        Text(method.description)
                            .font(.system(size: 11))
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(.rect(cornerRadius: 8))
                }
            }
            .gridCellColumns(1)
        }
    }
}
