//
//  SessionsView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 7/5/24.
//

import SwiftUI

struct SessionsView: View {
    
    @Binding var sessions: [Session]
    @Binding var isNewSessionPresented: Bool
    
    @State private var startCountDate = Date.now
    @State private var counter = 0
    
    @State private var isPavAnimating = false
    @State private var isPavPresented = false
    
    @State private var navigationSplitViewVisibility = NavigationSplitViewVisibility.doubleColumn
    
    var body: some View {
        NavigationSplitView(columnVisibility: $navigationSplitViewVisibility) {
            List($sessions, editActions: .all) { $session in
                NavigationLink {
                    SessionView(session: $session)
                } label: {
                    VStack(alignment: .leading) {
                        Text(session.class)
                        Text(session.lessonTime.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .overlay {
                if sessions.isEmpty {
                    ContentUnavailableView {
                        Label("No Sessions Available", systemImage: "list.clipboard")
                    } description: {
                        Text("Create a new session to get started!")
                    } actions: {
                        Button {
                            isNewSessionPresented.toggle()
                        } label: {
                            Text("Create New Session")
                        }
                    }
                }
            }
            .navigationTitle("Sessions")
            .toolbar {
                Button {
                    isNewSessionPresented.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        } detail: {
            ContentUnavailableView {
                Label("No Session Selected", systemImage: "square.and.pencil")
            } description: {
                Text("Select a session to open it!")
            } actions: {
                Button {
                    isNewSessionPresented.toggle()
                } label: {
                    Text("Create New Session")
                }
            }
        }
        .onChange(of: navigationSplitViewVisibility) { oldValue, newValue in
            if counter == 0 {
                startCountDate = Date.now
            }
            counter += 1
            print("change")
            if counter >= 4 && startCountDate < Date.now.addingTimeInterval(10) {
                withAnimation {
                    isPavPresented = true
                }
                withAnimation(.easeInOut(duration: 0.5).repeatCount(3)) {
                    isPavAnimating = true
                }
            }
            
            if startCountDate > Date.now.addingTimeInterval(10) {
                counter = 0
            }
        }
        .overlay(alignment: .bottomTrailing) {
            if isPavPresented {
                Button {
                    withAnimation {
                        isPavAnimating = false
                        isPavPresented = false
                    }
                } label: {
                    Image("Pav")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 64)
                        .padding()
                        .rotationEffect(isPavAnimating ? .degrees(-30) : .degrees(30))
                }
            }
        }
    }
}
