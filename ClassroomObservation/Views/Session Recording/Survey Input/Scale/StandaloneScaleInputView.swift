//
//  StandaloneScaleInputView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 15/4/24.
//

import SwiftUI

struct StandaloneScaleInputView: View {
    
    @Binding var record: ObservationRecord
    
    @State private var scaleComments = ScaleComments(scaleValue: 3, comments: "")
    
    var body: some View {
        let scaleValue = Binding {
            Double(scaleComments.scaleValue)
        } set: { newValue in
            scaleComments.scaleValue = Int(round(newValue))
        }
        
        ScrollView {
            VStack(alignment: .leading) {
                ScaleInputView(value: scaleValue)
                
                Text("Comments")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.top)
                
                TextEditor(text: $scaleComments.comments)
                    .frame(minHeight: 64)
                    .scrollContentBackground(.hidden)
                    .multilineTextAlignment(.leading)
                    .fontWeight(.medium)
                    .padding()
                    .background(.quinary)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .font(.title3)
            }
        }
        .onAppear {
            if let recordScaleComments = record.scaleComments {
                scaleComments = recordScaleComments
            } else {
                scaleComments = ScaleComments(scaleValue: 3, comments: "")
            }
        }
        .onChange(of: scaleComments) { oldValue, newValue in
            record = .scaleComments(newValue)
        }
    }
}
