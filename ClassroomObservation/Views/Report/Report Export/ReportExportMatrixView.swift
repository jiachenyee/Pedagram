//
//  ReportExportMatrixView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 1/6/24.
//

import Foundation
import SwiftUI

struct ReportExportMatrixView<ColumnHeader: Identifiable>: View {
    
    var rowHeaders: [String]
    var columnHeaders: [ColumnHeader]
    
    var title: String
    
    var columnHeaderLabel: (ColumnHeader) -> String
    var shouldHighlight: (String, ColumnHeader) -> Bool
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(.system(size: 11))
                    .foregroundStyle(.blue)
                    .fontWeight(.bold)
                
                ForEach(rowHeaders, id: \.self) { header in
                    Text(header)
                        .font(.system(size: 11))
                        .frame(height: 16)
                }
            }
            .padding(.trailing, 8)
            
            Divider()
                .padding(.leading, 8)
                .frame(height: Double(rowHeaders.count + 1) * 16)
            
            HStack(spacing: 0) {
                ForEach(columnHeaders) { columnHeader in
                    VStack(spacing: 0) {
                        Text(columnHeaderLabel(columnHeader))
                            .foregroundStyle(.secondary)
                            .font(.system(size: 11))
                        
                        ForEach(rowHeaders, id: \.self) { rowHeader in
                            if shouldHighlight(rowHeader, columnHeader) {
                                ZStack {
                                    Rectangle()
                                        .fill(.blue)
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.white)
                                        .imageScale(.small)
                                        .font(.system(size: 11))
                                }
                                .frame(height: 16)
                            } else {
                                Rectangle()
                                    .fill(.clear)
                                    .frame(height: 16)
                            }
                        }
                    }
                }
                .frame(width: 50)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.gray.opacity(0.1))
        .clipShape(.rect(cornerRadius: 8))
        .padding(.top, 8)
    }
}
