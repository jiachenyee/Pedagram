//
//  ChecklistOption.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 20/3/24.
//

import Foundation
import SwiftUI

struct ChecklistOption: Hashable, Identifiable {
    var id: String
    var title: LocalizedStringResource
    var description: LocalizedStringKey?
    
    init(title: LocalizedStringResource, description: LocalizedStringKey? = nil) {
        self.title = title
        
        self.description = description
        
        self.id = title.key
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
