//
//  ReportExportPage3.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 26/3/24.
//

import SwiftUI

struct ReportExportPage3: View {
    
    var session: Session
    
    var body: some View {
        ReportExportPage(page: 3) {
            Grid {
                GridRow {
                    VStack(alignment: .leading) {
                        Text("Students’ Confidence in Technology")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 16, weight: .bold))
                        
                        Text("How confident the students were with various technologies used within the classroom, when rated on a scale of 1 to 5.")
                            .font(.system(size: 11))
                    }
                    .gridCellColumns(3)
                    .padding(.top)
                }
                
                ReportExportStudentConfidenceInTechView(session: session)
            }
        }
    }
}
