//
//  ReportAggregateList.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 20/12/23.
//

import SwiftUI

struct ReportAggregateList: View {
    
    var session: Session
    var question: Question
    
    var body: some View {
        let results = session.observations.flatMap {
            $0[keyPath: question.path]?.stringArrayValue ?? []
        }
        
        let values = Set(results).map { result in
            (result, results.filter { value in
                value == result
            }.count)
        }.sorted {
            $0.1 > $1.1
        }
        
        ForEach(values, id: \.0) { value in
            HStack {
                Text(value.0)
                Spacer()
                Text("\(value.1)")
                    .foregroundStyle(.secondary)
                    .monospaced()
            }
        }
        Spacer()
    }
}
