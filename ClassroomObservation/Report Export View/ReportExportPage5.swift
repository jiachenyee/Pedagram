//
//  ReportExportPage5.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 26/3/24.
//

import SwiftUI

struct ReportExportPage5: View {
    
    var session: Session
    
    var body: some View {
        ReportExportPage(page: 5) {
            Grid {
                GridRow {
                    VStack(alignment: .leading) {
                        Text("What’s Going On")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 16, weight: .bold))
                        
                        Text("""
The task set by the teacher is categorised into _active_, _collaborative_, _constructive_, _authentic_, and _goal directed_.

**Active**: Students are engaged in using technology as a tool rather than passively receiving information from the technology.

**Collaborative**: Students use technology tools to collaborate with others rather than working individually at all times.

**Constructive**: Students use technology tools to connect new information to their prior knowledge rather than to passively receive information."

**Authentic**: Students use technology tools to link learning activities to the world beyond the instructional setting rather than working on decontextualized assignments.

**Goal Directed**: Students use technology tools to set goals, plan activities, monitor progress, and evaluate results rather than simply completing assignments without reflection.
""")
                        .font(.system(size: 11))
                    }
                    .gridCellColumns(3)
                    .padding(.top)
                }
                
                GridRow {
                    HStack(spacing: 0) {
                        VStack(spacing: 0) {
                            Text("Time")
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundStyle(.secondary)
                            
                            Divider()
                                .padding(.vertical, 4)
                            
                            ForEach(session.observations) { observation in
                                Text(observation.time, style: .time)
                                    .font(.system(size: 11))
                                    .frame(height: 21)
                            }
                        }
                        .frame(width: 74)
                        
                        Divider()
                            .frame(height: Double(session.observations.count + 1) * 21 + 8)
                        
                        HStack(spacing: 0) {
                            VStack(spacing: 0) {
                                Text("Task set by teacher")
                                    .font(.system(size: 11, weight: .semibold))
                                    .padding(.horizontal)
                                    .foregroundStyle(.secondary)
                                
                                Divider()
                                    .padding(.vertical, 4)
                                
                                ForEach(session.observations) { observation in
                                    if let value = observation.typeOfTaskSetByTeacher?.stringValue?.capitalized {
                                        Text(value)
                                            .font(.system(size: 11))
                                            .padding(.horizontal)
                                            .frame(height: 21)
                                    } else {
                                        Rectangle()
                                            .fill(.clear)
                                            .frame(height: 21)
                                    }
                                }
                            }
                            
                            VStack(spacing: 0) {
                                Text("What is the teacher doing")
                                    .font(.system(size: 11, weight: .semibold))
                                    .padding(.horizontal)
                                    .foregroundStyle(.secondary)
                                
                                Divider()
                                    .padding(.vertical, 4)
                                
                                ForEach(session.observations) { observation in
                                    if let value = observation.whatIsTheTeacherDoing?.stringValue?.capitalized {
                                        Text(value)
                                            .font(.system(size: 11))
                                            .padding(.horizontal)
                                            .frame(height: 21)
                                    } else {
                                        Rectangle()
                                            .fill(.clear)
                                            .frame(height: 21)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(.rect(cornerRadius: 8))
                    .gridCellColumns(3)
                }
            }
        }
    }
}
