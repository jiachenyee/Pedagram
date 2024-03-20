//
//  ChecklistOption.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 20/3/24.
//

import Foundation

struct ChecklistOption: Hashable, Identifiable {
    var id: String { title }
    var title: String
    var description: String?
}
