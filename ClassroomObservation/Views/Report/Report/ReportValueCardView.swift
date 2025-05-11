//
//  ReportValueCardView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 7/5/24.
//

import SwiftUI

struct ReportValueCardView: View {
    
    var title: LocalizedStringKey
    var value: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.secondary)
            
            ViewThatFits {
                Text(value)
                    .monospacedDigit()
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(value)
                    .monospacedDigit()
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(value)
                    .monospacedDigit()
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(value)
                    .monospacedDigit()
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(value)
                    .monospacedDigit()
                    .font(.headline)
                    .fontWeight(.bold)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.1))
        .clipShape(.rect(cornerRadius: 8))
        .multilineTextAlignment(.center)
    }
}
