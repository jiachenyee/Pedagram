//
//  SessionView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 26/9/23.
//

import SwiftUI

struct SessionView: View {
    
    @Binding var session: Session
    
    var body: some View {
        List {
            Text(session.lessonTime.formatted(date: .abbreviated, time: .shortened))
                .listRowBackground(EmptyView())
                .listRowInsets(.init(top: 0, leading: 4, bottom: 0, trailing: 4))
                .foregroundStyle(.secondary)
            
            switch session.state {
            case .notStarted:
                Section("Instructions") {
                    Label("Every 15 minutes, you will have to add a brand new observation.", systemImage: "1.circle")
                    Label("Fill out each observation based on what you see going on in the classroom.", systemImage: "2.circle")
                    Label("When you are ready to start, press Start Recording.", systemImage: "3.circle")
                    Label("When you are done, press Finish Recording to stop.", systemImage: "4.circle")
                }
                
                Button("Start Recording") {
                    withAnimation {
                        session.state = .recording
                    }
                }
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
