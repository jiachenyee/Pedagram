//
//  ObservationRecordPreviewView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 4/3/24.
//

import SwiftUI

struct ObservationRecordPreviewView: View {
    
    var observation: Observation
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(Question.allCases, id: \.rawValue) { question in
                        HStack {
                            Text(question.unformattedTitle)
                            Spacer()
                            Text(observation[keyPath: question.path]?.value ?? "")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                Section {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("Observation at \(observation.time.formatted(date: .omitted, time: .shortened))")
        }
    }
}
