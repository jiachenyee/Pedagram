//
//  ContentView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 22/9/23.
//

import SwiftUI
import Forever

struct ContentView: View {
    
    @Forever("observations") private var sessions: [Session] = []
    @State private var isNewSessionPresented = false
    @State private var showOnboarding = true

    var body: some View {
        Group {
            if sessions.isEmpty || showOnboarding {
                OnboardingView(isNewSessionPresented: $isNewSessionPresented)
            } else {
                SessionsView(sessions: $sessions, isNewSessionPresented: $isNewSessionPresented)
            }
        }
        .sheet(isPresented: $isNewSessionPresented) {
            NewSessionView { record in
                sessions.insert(record, at: 0)
                showOnboarding = false
            }
        }
        .onAppear {
            showOnboarding = sessions.isEmpty
        }
    }
}

#Preview {
    ContentView()
}
