//
//  SessionNotStartedTimeSelectionView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 15/4/24.
//

import Foundation
import SwiftUI

struct SessionNotStartedTimeSelectionView: View {
    
    @Binding var recordingFrequency: Double?
    
    var minutes: Int
    var message: String
    var systemImage: String
    
    var body: some View {
        Button {
            recordingFrequency = Double(minutes)
        } label: {
            Label {
                VStack(alignment: .leading) {
                    Text("\(minutes) minutes")
                        .fontWeight(.bold)
                        .monospacedDigit()
                    Text(message)
                }
                .foregroundStyle(Color(.label))
                
                Spacer()
                
                if (recordingFrequency ?? 15) == Double(minutes) {
                    Image(systemName: "checkmark")
                }
            } icon: {
                Image(systemName: systemImage)
            }
        }
    }
}
