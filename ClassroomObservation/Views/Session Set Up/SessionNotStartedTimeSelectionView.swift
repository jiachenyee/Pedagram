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
    var message: LocalizedStringKey
    var systemImage: String
    
    var body: some View {
        Button {
            recordingFrequency = Double(minutes)
        } label: {
            Label {
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(minutes) minutes")
                            .fontWeight(.bold)
                            .monospacedDigit()
                        Text(message)
                    }
                    .foregroundStyle(Color(.label))
                    
                    Spacer()
                    
                    Image(systemName: "checkmark")
                        .opacity((recordingFrequency ?? 15) == Double(minutes) ? 1 : 0)
                }
            } icon: {
                Image(systemName: systemImage)
            }
        }
    }
}
