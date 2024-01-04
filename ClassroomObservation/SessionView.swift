//
//  SessionView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 26/9/23.
//

import SwiftUI

struct SessionView: View {
    
    @Binding var session: Session
    
    @State private var isNewEntryPresented = false
    
    var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State private var timeUntilNextSession: String?
    @State private var isReportPresented = false
    
    var body: some View {
        List {
            Text(session.lessonTime.formatted(date: .abbreviated, time: .shortened))
                .listRowBackground(EmptyView())
                .listRowInsets(.init(top: 0, leading: 4, bottom: 0, trailing: 4))
                .foregroundStyle(.secondary)
            
            Section {
                if let timeUntilNextSession {
                    Text("\(timeUntilNextSession)")
                        .monospacedDigit()
                        .contentTransition(.numericText())
                        .font(.title)
                        .fontWeight(timeUntilNextSession == "Record Now" ? .medium : .regular)
                        .foregroundStyle(timeUntilNextSession == "Record Now" ? Color.accentColor : Color.primary)
                    
                    Button {
                        isNewEntryPresented.toggle()
                    } label: {
                        Label("Create New Record", systemImage: "plus")
                    }
                } else {
                    Button {
                        isNewEntryPresented.toggle()
                    } label: {
                        Label("Create New Record", systemImage: "plus")
                    }
                }
            } footer: {
                Text("Create a new record every 15 minutes to get consistent results!")
            }
            
            if !session.observations.isEmpty {
                Section {
                    ForEach($session.observations, editActions: .delete) { $entry in
                        Text("\(entry.time.formatted(date: .omitted, time: .shortened)) Record")
                    }
                } header: {
                    Text("Records")
                }
                
                Section {
                    Button {
                        isReportPresented = true
                    } label: {
                        Label("Report", systemImage: "list.clipboard")
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $isReportPresented) {
            ReportView(session: session)
        }
        .onReceive(timer) { _ in
            guard let latestEntryDate = session.observations.first?.time else { return }
            let secondsSinceLastEntry = abs(latestEntryDate.timeIntervalSinceNow)
            
            let numberOfSeconds = 15 * 60.0
            let secondsUntilNextEntry = Int(round(numberOfSeconds - secondsSinceLastEntry))
            
            if secondsUntilNextEntry < 3600 {
                timeUntilNextSession = nil
            } else if secondsUntilNextEntry < 0 {
                timeUntilNextSession = "Record Now"
            } else {
                let minutes = secondsUntilNextEntry / 60
                let seconds = secondsUntilNextEntry % 60
                
                withAnimation {
                    timeUntilNextSession = "\(minutes < 10 ? "0" : "")\(minutes)m \(seconds < 10 ? "0" : "")\(seconds)s"
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
        }
        .navigationTitle(session.class)
        .fullScreenCover(isPresented: $isNewEntryPresented) {
            SurveyInputView { entry in
                session.observations.insert(entry, at: 0)
            }
        }
    }
}
