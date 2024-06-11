//
//  ReportView+Export.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 20/5/24.
//

import SwiftUI
import SwiftUIPDF

extension ReportView {
    @MainActor func export() async -> URL {
        let pdf = PDF(sections: pages(), dynamicTypeSize: .xSmall, footerView: { number in
            HStack {
                Text("Report generated on \(Date.now.formatted(date: .complete, time: .omitted)) by [Pedagram](https://pedagram.com) (pedagram.com).")
                Spacer()
                Text("\(number)")
            }
            .font(.system(size: 11, weight: .regular))
            .kerning(-0.2)
        }, footerHeight: 48)
        
        let fileName = "\(session.class)-\(session.subject ?? "")-\((session.observations.first?.time ?? .now).formatted(date: .numeric, time: .omitted).replacingOccurrences(of: "/", with: "-")).pdf"
        
        let pdfURL = await pdf.exportPDF(name: fileName)
        
        return pdfURL
    }
    
    func createExportView<Content: View>(title: String, description: String, @ViewBuilder content: @escaping () -> Content) -> PDFSection {
        PDFSection {
            PDFViewGroup(VStack {
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    .foregroundStyle(.secondary)
                
                Text(description)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.bottom))
            
            PDFViewGroup(content())
        }
    }
}
