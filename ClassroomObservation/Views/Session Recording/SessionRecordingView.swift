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
    
    @State private var timeUntilNextSession = "Create Observation Now"
    @State private var isFinishRecordingAlertPresented = false
    
    @State private var isBlue = false
    
    var body: some View {
        Section {
            if timeUntilNextSession == "Create Observation Now" {
                Text("Create Observation Now")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundStyle(isBlue ? Color.accentColor : Color.primary)
                    .onTapGesture {
                        isNewEntryPresented.toggle()
                    }
            } else {
                Text("\(timeUntilNextSession)")
                    .monospacedDigit()
                    .contentTransition(.numericText())
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.primary)
                    .onTapGesture {
                        isNewEntryPresented.toggle()
                    }
            }
            
            Button {
                isNewEntryPresented.toggle()
            } label: {
                Label("Create New Observation", systemImage: "plus")
            }
            .fullScreenCover(isPresented: $isNewEntryPresented) {
                SurveyInputView(recordingFrequency: session.recordingFrequency ?? 15) { entry in
                    session.observations.insert(entry, at: 0)
                }
            }
        } header: {
            Text("Time until next observation")
        } footer: {
            Text("Create a new observation every \(Int(session.recordingFrequency ?? 15)) minutes to get consistent results!")
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
        }
        
        SessionRecordingAddPhotoView(session: $session)
        
        if !session.observations.isEmpty {
            Section {
                Button("End Session") {
                    isFinishRecordingAlertPresented = true
                }
            }
            .alert("End Session", isPresented: $isFinishRecordingAlertPresented) {
                Button("End Session") {
                    withAnimation {
                        session.state = .finished
                    }
                }
                
                Button(role: .cancel) {
                } label: {
                    Text("Cancel")
                }
            } message: {
                Text("Are you sure you want to end the observation session?")
            }

        }
    }
    
    func reloadTimer() {
        let latestObservationDate = session.observations.max(by: {
            $0.time < $1.time
        })?.time ?? .distantPast
        
        let secondsSinceLastEntry = abs(latestObservationDate.timeIntervalSinceNow)
        
        let numberOfSeconds = (session.recordingFrequency ?? 15) * 60.0
        let secondsUntilNextEntry = Int(round(numberOfSeconds - secondsSinceLastEntry))
        
        if secondsUntilNextEntry < 0 {
            timeUntilNextSession = "Create Observation Now"
        } else {
            let minutes = secondsUntilNextEntry / 60
            let seconds = secondsUntilNextEntry % 60
            
            withAnimation {
                timeUntilNextSession = "\(minutes < 10 ? "0" : "")\(minutes)m \(seconds < 10 ? "0" : "")\(seconds)s"
            }
        }
    }
}
