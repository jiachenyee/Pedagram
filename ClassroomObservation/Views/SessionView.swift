//
//  SessionView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 26/9/23.
//

import SwiftUI

struct SessionView: View {
    
    @Binding var session: Session
    
    @State private var isPrerecordingInfoViewPresented = false
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                if let subject = session.subject {
                    Text(subject)
                        .fontWeight(.bold)
                }
                Text(session.lessonTime.formatted(date: .abbreviated, time: .shortened))
            }
            .listRowBackground(EmptyView())
            .listRowInsets(.init(top: 0, leading: 4, bottom: 0, trailing: 4))
            .foregroundStyle(.secondary)
            
            switch session.state {
            case .notStarted:
                SessionNotStartedView(session: $session)
            case .recording:
                SessionRecordingView(session: $session)
            case .finished:
                SessionCompletionView(session: $session)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
        .navigationTitle(session.class)
    }
}
