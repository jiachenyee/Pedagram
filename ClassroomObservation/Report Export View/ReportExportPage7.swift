//
//  ReportExportPage7.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 26/3/24.
//

import SwiftUI

struct ReportExportPage7: View {
    
    var session: Session
    
    var body: some View {
        ReportExportPage(page: 7) {
            Grid {
                GridRow {
                    VStack(alignment: .leading) {
                        Text("Comments")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 16, weight: .bold))
                        
                        Text("These are subjective comments taken from the observer.")
                            .font(.system(size: 11))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.top)
                    .gridCellColumns(3)
                }
                
                GridRow {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            let comments = session.observations.flatMap {
                                $0.comments?.stringArrayValue ?? []
                            }
                            
                            ForEach(comments, id: \.self) { comment in
                                Text(comment)
                                    .font(.system(size: 11))
                                    .frame(height: 21)
                                
                                if comment != comments.last {
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
                                let comments = session.observations.flatMap {
                                    $0.comments?.stringArrayValue ?? []
                                }
                                Text("\(comments.count)")
                                    .monospacedDigit()
                                    .font(.system(size: 18, weight: .bold))
                                
                                Text("Comments")
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
