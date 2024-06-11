//
//  ObservationRowView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 5/3/24.
//

import SwiftUI

struct ObservationRowView: View {
    
    @State private var isPreviewPresented = false
    
    @Binding var entry: Observation
    
    var body: some View {
        Button {
            isPreviewPresented.toggle()
        } label: {
            Text("\(entry.time.formatted(date: .omitted, time: .shortened)) Observation")
        }
        .sheet(isPresented: $isPreviewPresented) {
            ObservationRecordPreviewView(observation: entry)
        }
    }
}
