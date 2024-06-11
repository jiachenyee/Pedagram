//
//  SessionNotStartedView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 15/4/24.
//

import SwiftUI

struct SessionNotStartedView: View {
    
    @Binding var session: Session
    
    var body: some View {
        Section {
            SessionNotStartedTimeSelectionView(recordingFrequency: $session.recordingFrequency,
                                               minutes: 10,
                                               message: "Shorter observation durations can provide more granular data entry.",
                                               systemImage: "hare")
            
            SessionNotStartedTimeSelectionView(recordingFrequency: $session.recordingFrequency,
                                               minutes: 15,
                                               message: "Longer observation durations can allow for more time to input data.",
                                               systemImage: "tortoise")
        } header: {
            Text("Observation Duration")
        } footer: {
            Text("Set the interval between each observation. You would be notified to create a new observation every \(Int(session.recordingFrequency ?? 15)) minutes.")
        }
        
        Section {
            Button("Start Recording") {
                withAnimation {
                    session.state = .recording
                }
            }
        } footer: {
            Text("When you are ready to start, press Start Recording. The timer will start after you take the first recording.")
        }
    }
}
