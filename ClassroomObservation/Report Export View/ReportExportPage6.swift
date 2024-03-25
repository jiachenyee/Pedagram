//
//  ReportExportPage6.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 26/3/24.
//

import SwiftUI

struct ReportExportPage6: View {
    
    var session: Session
    
    var body: some View {
        ReportExportPage(page: 6) {
            Grid {
                GridRow {
                    VStack(alignment: .leading) {
                        Text("Questions Posed")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 16, weight: .bold))
                        
                        Text("Questions posed by the teacher to the students.")
                            .font(.system(size: 11))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.top)
                    .gridCellColumns(3)
                }
                
                GridRow {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            let questions = session.observations.flatMap {
                                $0.questionsPosedByTeacherToStudents?.stringArrayValue ?? []
                            }
                            
                            ForEach(questions, id: \.self) { question in
                                Text(question)
                                    .font(.system(size: 11))
                                    .frame(height: 21)
                                
                                if question != questions.last {
                                    Divider()
                                }
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(.rect(cornerRadius: 8))
                        
                        VStack {
                            VStack(alignment: .leading) {
                                let questions = session.observations.flatMap {
                                    $0.questionsPosedByTeacherToStudents?.stringArrayValue ?? []
                                }
                                Text("\(questions.count)")
                                    .monospacedDigit()
                                    .font(.system(size: 18, weight: .bold))
                                
                                Text("Questions Asked")
                                    .font(.system(size: 11))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.secondary)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(.rect(cornerRadius: 8))
                            
                            VStack(alignment: .leading) {
                                let questions = session.observations.flatMap {
                                    $0.questionsPosedByTeacherToStudents?.stringArrayValue ?? []
                                }
                                Text("\(Double(questions.count) / Double(session.observations.count), specifier: "%.2f")")
                                    .monospacedDigit()
                                    .font(.system(size: 18, weight: .bold))
                                
                                Text("Average")
                                    .font(.system(size: 11))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.secondary)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(.rect(cornerRadius: 8))
                        }
                        .frame(width: 155)
                    }
                    .gridCellColumns(3)
                }
            }
        }
    }
}
