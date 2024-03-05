//
//  SessionCompletionView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 5/3/24.
//

import SwiftUI

struct SessionCompletionView: View {
    
    @Binding var session: Session
    
    @State private var isReportPresented = false
    
    var body: some View {
        Section {
            ForEach($session.observations, editActions: .delete) { $entry in
                ObservationRowView(entry: $entry)
            }
        } header: {
            Text("Observations")
        }
        
        Section {
            Button {
                isReportPresented = true
            } label: {
                Label("Report", systemImage: "list.clipboard")
            }
        }
        .sheet(isPresented: $isReportPresented) {
            ReportView(session: session)
        }
    }
}
