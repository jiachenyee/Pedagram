//
//  SurveyInputQuickCompletionButton.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 20/12/23.
//

import SwiftUI

struct SurveyInputQuickCompletionButton: View {
    
    @Binding var value: Int
    var increment: Int
    
    var body: some View {
        Button {
            value += increment
        } label: {
            Text("\(increment > 0 ? "+" : increment < 0 ? "-" : "")\(abs(increment))")
                .font(.title3)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .buttonStyle(.bordered)
        .disabled(value <= 0 && increment < 0)
    }
}
