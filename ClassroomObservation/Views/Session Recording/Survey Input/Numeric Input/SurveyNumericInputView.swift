//
//  SurveyNumericInputView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 5/3/24.
//

import SwiftUI

struct SurveyNumericInputView: View {
    
    @Binding var record: ObservationRecord
    
    var body: some View {
        let value = Binding {
            record.numericValue ?? 0
        } set: { newValue in
            record = .numeric(newValue)
        }
        
        ScrollView {
            VStack {
                TextField("Number",
                          value: value,
                          format: .number)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .font(.title)
                .fontWeight(.medium)
                .padding(.vertical)
                .background(.quinary)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                HStack {
                    SurveyInputQuickCompletionButton(value: value, increment: 1)
                    SurveyInputQuickCompletionButton(value: value, increment: -1)
                }
                
                HStack {
                    SurveyInputQuickCompletionButton(value: value, increment: 5)
                    SurveyInputQuickCompletionButton(value: value, increment: -5)
                }
                HStack {
                    SurveyInputQuickCompletionButton(value: value, increment: 10)
                    SurveyInputQuickCompletionButton(value: value, increment: -10)
                }
            }
        }
    }
}
