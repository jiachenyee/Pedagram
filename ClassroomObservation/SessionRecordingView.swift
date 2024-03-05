//
//  SessionRecordingView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 5/3/24.
//

import SwiftUI

struct SessionRecordingView: View {
    
    @Binding var session: Session
    
    @State private var startDate = Date()
    
    @State private var isNewEntryPresented = false
    
    var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State private var timeUntilNextSession = "Create Record Now"
    @State private var isFinishRecordingAlertPresented = false
    
    @State private var isBlue = false
    
    var body: some View {
        
        Section("Time until next recording") {
            Text("\(timeUntilNextSession)")
                .monospacedDigit()
                .contentTransition(.numericText())
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(timeUntilNextSession == "Create Record Now" && isBlue ? Color.accentColor : Color.primary)
        }
        Section {
            Button {
                isNewEntryPresented.toggle()
            } label: {
                Label("Create New Observation", systemImage: "plus")
            }
            .fullScreenCover(isPresented: $isNewEntryPresented) {
                SurveyInputView { entry in
                    session.observations.insert(entry, at: 0)
                }
            }
        } footer: {
            Text("Create a new observation every 15 minutes to get consistent results!")
        }
        .onReceive(timer) { _ in
            reloadTimer()
        }
        .onAppear {
            startDate = .now
            reloadTimer()
            withAnimation(.linear(duration: 0.5).repeatForever()) {
                isBlue.toggle()
            }
        }
        
        if !session.observations.isEmpty {
            Section {
                ForEach($session.observations, editActions: .delete) { $entry in
                    ObservationRowView(entry: $entry)
                }
            } header: {
                Text("Observations")
            }
            
            Section {
                Button("Finish Recording") {
                    isFinishRecordingAlertPresented = true
                }
            }
            .alert("Finish Recording", isPresented: $isFinishRecordingAlertPresented) {
                Button("Finish Recording") {
                    withAnimation {
                        session.state = .finished
                    }
                }
                
                Button(role: .cancel) {
                } label: {
                    Text("Cancel")
                }
            } message: {
                Text("Are you sure you want to finish recording?")
            }

        }
    }
    
    func reloadTimer() {
        let latestObservationDate = session.observations.max(by: {
            $0.time < $1.time
        })?.time ?? .distantPast
        
        let secondsSinceLastEntry = abs(latestObservationDate.timeIntervalSinceNow)
        
        let numberOfSeconds = 15 * 60.0
        let secondsUntilNextEntry = Int(round(numberOfSeconds - secondsSinceLastEntry))
        
        if secondsUntilNextEntry < 0 {
            timeUntilNextSession = "Create Record Now"
        } else {
            let minutes = secondsUntilNextEntry / 60
            let seconds = secondsUntilNextEntry % 60
            
            withAnimation {
                timeUntilNextSession = "\(minutes < 10 ? "0" : "")\(minutes)m \(seconds < 10 ? "0" : "")\(seconds)s"
            }
        }
    }
}
