//
//  ReportExportCommentView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 20/5/24.
//

import SwiftUI

struct ReportExportCommentView: View {
    
    let observation: Observation
    
    var body: some View {
        if let comment = observation.whatIsTheLevelOfStudentEngagement?.scaleComments?.comments, !comment.isEmpty {
            let time = observation.time.formatted(date: .omitted, time: .shortened)
            HStack(alignment: .top) {
                Text(time)
                    .foregroundStyle(.secondary)
                    .monospacedDigit()
                Text(comment)
            }
        }
    }
}
