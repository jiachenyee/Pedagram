//
//  ReportExportPage.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 26/3/24.
//

import SwiftUI

struct ReportExportPage<Content: View>: View {
    
    var page: Int
    
    @ViewBuilder
    var content: Content
    
    var body: some View {
        VStack(alignment: .leading) {
            content
            Spacer(minLength: 0)
            HStack {
                Text("Report generated on \(Date.now.formatted(date: .complete, time: .omitted)) by [Pedagram](https://pedagram.com).")
                Spacer()
                Text("\(page)")
            }
            .font(.system(size: 11, weight: .regular))
            .kerning(-0.2)
            .padding(.top, 32)
        }
        .padding(57)
        .frame(width: 595, height: 842)
        .background(.white)
        .foregroundStyle(.black)
    }
}
