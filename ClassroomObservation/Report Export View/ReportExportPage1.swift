//
//  ReportExportPage1.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 26/3/24.
//

import SwiftUI

struct ReportExportPage1: View {
    
    var session: Session
    
    var body: some View {
        ReportExportPage(page: 1) {
            HStack {
                VStack(alignment: .leading) {
                    Text(session.class)
                        .font(.system(size: 30, weight: .bold))
                        .lineLimit(1)
                    Text("\(session.lessonTime.formatted(date: .abbreviated, time: .omitted)) • \(session.lessonTime.formatted(date: .omitted, time: .shortened))")
                        .font(.system(size: 20, weight: .regular))
                }
                
                Spacer()
            }
            
            Grid {
                ReportExportSessionInfoView(session: session)
                ReportExportStudentsWorkingWithTechnologyView(session: session)
            }
        }
    }
}
