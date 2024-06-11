//
//  ScaleInputView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 1/3/24.
//

import SwiftUI

struct ScaleInputView: View {
    
    var range: ClosedRange<Double> = 1...5
    
    @State private var highlightedNumber = 5
    
    @Binding var value: Double
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text("Not Engaged")
                .padding(.bottom, 4)
            VStack {
                HStack(alignment: .bottom) {
                    ForEach(1..<6) { value in
                        if value != 1 {
                            Spacer()
                        }
                        
                        Text("\(value)")
                            .font(highlightedNumber == value ? .body : .caption)
                            .fontWeight(highlightedNumber == value ? .bold : .regular)
                        
                        if value != 5 {
                            Spacer()
                        }
                    }
                    .monospacedDigit()
                }
                .padding(.horizontal, 8)
                
                Slider(value: $value, in: range,
                       step: 1) { _ in
                    
                    withAnimation {
                        highlightedNumber = Int(round(value))
                    }
                }
            }
            Text("Highly Engaged")
                .padding(.bottom, 4)
        }
        .onAppear {
            if value == 0 {
                value = 3
            }
            highlightedNumber = Int(round(value))
        }
    }
}
