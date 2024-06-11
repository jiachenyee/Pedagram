//
//  ReportMatrixView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 7/5/24.
//

import SwiftUI

struct ReportMatrixView<HeaderView: View, ColumnHeader: Identifiable>: View {
    
    var rowHeaders: [String]
    var columnHeaders: [ColumnHeader]
    
    @ViewBuilder var headerView: HeaderView
    
    var columnHeaderLabel: (ColumnHeader) -> String
    var shouldHighlight: (String, ColumnHeader) -> Bool
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                headerView
                
                ForEach(rowHeaders, id: \.self) { header in
                    Text(header)
                        .font(.system(size: 16))
                        .frame(height: 24)
                }
            }
            .padding(.trailing, 8)
            
            Divider()
                .padding(.leading)
            
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(columnHeaders) { columnHeader in
                        VStack(spacing: 0) {
                            Text(columnHeaderLabel(columnHeader))
                                .foregroundStyle(.secondary)
                            
                            ForEach(rowHeaders, id: \.self) { rowHeader in
                                if shouldHighlight(rowHeader, columnHeader) {
                                    ZStack {
                                        Rectangle()
                                            .fill(.blue)
                                        Image(systemName: "checkmark")
                                            .foregroundStyle(.white)
                                            .imageScale(.small)
                                    }
                                    .frame(height: 24)
                                } else {
                                    Rectangle()
                                        .fill(.clear)
                                        .frame(height: 24)
                                }
                            }
                        }
                    }
                    .frame(width: 100)
                }
            }
        }
    }
}
