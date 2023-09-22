//
//  ObservationView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 26/9/23.
//

import SwiftUI

struct ObservationView: View {
    
    @Binding var observation: Observation
    
    @State private var isNewEntryPresented = false
    @State private var isReportPresented = false
    
    var body: some View {
        List {
            Section("Records") {
                ForEach(observation.entries) { entry in
                    Text("\(entry.time.formatted(date: .omitted, time: .shortened)) Record")
                }
            }
            
            Button("Generate Report", systemImage: "list.clipboard") {
                isReportPresented.toggle()
            }
        }
        .sheet(isPresented: $isReportPresented) {
            ReportView(observation: observation)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isNewEntryPresented.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .navigationTitle(observation.class)
        .sheet(isPresented: $isNewEntryPresented) {
            SurveyInputView() { entry in
                observation.entries.append(entry)
            }
        }
    }
}
