//
//  ReportExportSessionInfoView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 26/3/24.
//

import SwiftUI

struct ReportExportSessionInfoView: View {
    
    var session: Session
    
    var body: some View {
        GridRow {
            VStack {
                Text(session.grade)
                    .font(.system(size: 18, weight: .bold))
                Text("Grade")
            }
            .font(.system(size: 11))
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .clipShape(.rect(cornerRadius: 8))
            .gridCellColumns(1)
            
            VStack {
                Text("\(session.enrolment)")
                    .font(.system(size: 18, weight: .bold))
                Text("Enrolment")
            }
            .font(.system(size: 11))
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .clipShape(.rect(cornerRadius: 8))
            .gridCellColumns(1)
            
            VStack {
                Text("\(session.observations.count)")
                    .font(.system(size: 18, weight: .bold))
                Text("Observations Recorded")
            }
            .font(.system(size: 11))
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .clipShape(.rect(cornerRadius: 8))
            .gridCellColumns(1)
        }
    }
}
