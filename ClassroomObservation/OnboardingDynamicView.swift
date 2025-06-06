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
    
    var title: LocalizedStringKey
    var description: LocalizedStringKey
    
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
                GeometryReader { reader in
                    VStack {
                        content
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .frame(height: reader.size.height / 2)
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
}
