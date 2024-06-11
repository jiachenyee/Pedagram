//
//  ReportExportStudentConfidenceInTechView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 26/3/24.
//

import SwiftUI

struct ReportExportStudentConfidenceInTechView: View {
    
    var session: Session
    
    var body: some View {
//        GridRow {
//            let technologiesUsed = Array(Set(session.observations.compactMap {
//                $0.howConfidentWereStudentsInTheUseOfEachTechnology?.dictValue?.keys.map({ $0 })
//            }.flatMap { $0 })).sorted()
//            
//            VStack {
//                HStack {
//                    VStack(alignment: .leading, spacing: 0) {
//                        Text("Technologies")
//                            .foregroundStyle(.secondary)
//                            .font(.system(size: 11, weight: .bold))
//                            .frame(height: 21)
//                        
//                        ForEach(technologiesUsed, id: \.self) { technology in
//                            Text(technology)
//                                .font(.system(size: 11))
//                                .frame(height: 21)
//                        }
//                    }
//                    .padding(.trailing, 8)
//                    
//                    Grid(horizontalSpacing: 0, verticalSpacing: 0) {
//                        GridRow {
//                            ForEach(Array(session.sortedObservations.reversed())) { observation in
//                                Text(observation.time, style: .time)
//                                    .foregroundStyle(.secondary)
//                                    .font(.system(size: 11, weight: .bold))
//                                    .frame(height: 21)
//                            }
//                        }
//                        
//                        ForEach(technologiesUsed, id: \.self) { technology in
//                            GridRow {
//                                ForEach(Array(session.sortedObservations.reversed())) { observation in
//                                    let observationDict = observation.howConfidentWereStudentsInTheUseOfEachTechnology?.dictValue ?? [:]
//                                    if let rating = observationDict[technology] {
//                                        Text("\(rating)")
//                                            .monospaced()
//                                            .font(.system(size: 11))
//                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                                            .frame(height: 21)
//                                            .background(.blue.opacity(Double(rating) / 5))
//                                            .foregroundStyle(rating > 2 ? .white : .black)
//                                    } else {
//                                        Rectangle()
//                                            .fill(.clear)
//                                            .frame(height: 21)
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            .padding()
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .background(Color.gray.opacity(0.1))
//            .clipShape(.rect(cornerRadius: 8))
//            .gridCellColumns(3)
//        }
        EmptyView()
    }
}
