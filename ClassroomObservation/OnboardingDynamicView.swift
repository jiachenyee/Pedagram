//
//  OnboardingDynamicView.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 14/5/24.
//

import SwiftUI

struct OnboardingDynamicView<Content: View>: View {
    
    @ViewBuilder
    var content: Content
    
    var title: String
    var description: String
    
    var body: some View {
        GeometryReader { reader in
            let isHorizontal = reader.size.width > reader.size.height
            
            if isHorizontal {
                HStack {
                    content
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Divider()
                        .padding(.horizontal)
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(description)
                    }
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
            } else {
                VStack {
                    content
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Divider()
                        .padding(.vertical)
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(description)
                    }
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            }
        }
    }
}
