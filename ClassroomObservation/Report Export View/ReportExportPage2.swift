//
//  ReportExportPage2.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 26/3/24.
//

import SwiftUI

struct ReportExportPage2: View {
    
    var session: Session
    
    var body: some View {
        ReportExportPage(page: 2) {
            Grid {
                ReportExportStudentEngagementView(session: session)
            }
        }
    }
}
