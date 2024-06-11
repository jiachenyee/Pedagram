//
//  InputType.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 15/4/24.
//

import Foundation

enum InputType {
    case numeric
    case openEndedList
    case options([ChecklistOption])
    case scale
    case dict(WritableKeyPath<Observation, ObservationRecord?>)
    case text
}
