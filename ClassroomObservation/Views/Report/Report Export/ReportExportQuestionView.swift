//
//  ReportExportQuestionView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 1/6/24.
//

import Foundation
import SwiftUI

struct ReportExportQuestionView: View {
    
    let text: String
    let time: Date
    
    var body: some View {
        let time = time.formatted(date: .omitted, time: .shortened)
        
        HStack(alignment: .top) {
            Text(time)
                .foregroundStyle(.secondary)
                .monospacedDigit()
            Text(text)
        }
    }
}
