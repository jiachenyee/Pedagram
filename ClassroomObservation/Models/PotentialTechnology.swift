//
//  PotentialTechnology.swift
//  ClassroomObservation
//
//  Created by Jia Chen Yee on 1/3/24.
//

import Foundation

struct PotentialTechnology: Identifiable {
    
    var id: String { (developer ?? "CUSTOM_") + name }
    
    var name: String
    var developer: String?
    
    static let all = appleTechnologies + otherTools + microsoftTools + googleTools
    static let appleTechnologies: [PotentialTechnology] = [
        PotentialTechnology(name: "Keynote", developer: "Apple"),
        PotentialTechnology(name: "Pages", developer: "Apple"),
        PotentialTechnology(name: "Numbers", developer: "Apple"),
        PotentialTechnology(name: "Apple Classroom", developer: "Apple"),
        PotentialTechnology(name: "Swift Playgrounds", developer: "Apple"),
        PotentialTechnology(name: "iMovie", developer: "Apple"),
        PotentialTechnology(name: "GarageBand", developer: "Apple"),
        PotentialTechnology(name: "Clips", developer: "Apple"),
        PotentialTechnology(name: "Apple Books", developer: "Apple"),
        PotentialTechnology(name: "Reality Composer", developer: "Apple"),
        PotentialTechnology(name: "Safari", developer: "Apple"),
        PotentialTechnology(name: "Maps", developer: "Apple"),
        PotentialTechnology(name: "Freeform", developer: "Apple"),
        PotentialTechnology(name: "AirPlay", developer: "Apple"),
        PotentialTechnology(name: "Apple Sports", developer: "Apple"),
        
        PotentialTechnology(name: "iPad", developer: "Apple"),
        PotentialTechnology(name: "Mac", developer: "Apple"),
        PotentialTechnology(name: "iPhone", developer: "Apple"),
        PotentialTechnology(name: "Apple TV", developer: "Apple"),
        PotentialTechnology(name: "Apple Vision Pro", developer: "Apple")
    ]
    static let otherTools: [PotentialTechnology] = [
        PotentialTechnology(name: "Kahoot!", developer: "Kahoot!"),
        PotentialTechnology(name: "Quizlet", developer: "Quizlet"),
        PotentialTechnology(name: "ScratchJr", developer: "Scratch"),
        PotentialTechnology(name: "Nearpod", developer: "Nearpod"),
        PotentialTechnology(name: "Tynker", developer: "Tynker"),
        
        PotentialTechnology(name: "Padlet", developer: "Padlet")
    ]
    
    static let googleTools = [
        PotentialTechnology(name: "Google Classroom", developer: "Google"),
        PotentialTechnology(name: "Google Docs", developer: "Google"),
        PotentialTechnology(name: "Google Slides", developer: "Google"),
        PotentialTechnology(name: "Google Sheets", developer: "Google"),
        PotentialTechnology(name: "Google Maps", developer: "Google"),
        PotentialTechnology(name: "Google Forms", developer: "Google"),
        PotentialTechnology(name: "Google Drive", developer: "Google"),
        PotentialTechnology(name: "Google Earth", developer: "Google"),
        PotentialTechnology(name: "Google Meet", developer: "Google"),
        PotentialTechnology(name: "Google Translate", developer: "Google"),
    ]
    
    static let microsoftTools = [
        PotentialTechnology(name: "Microsoft Powerpoint", developer: "Microsoft"),
        PotentialTechnology(name: "Microsoft Excel", developer: "Microsoft"),
        PotentialTechnology(name: "Microsoft Word", developer: "Microsoft"),
        PotentialTechnology(name: "Microsoft Teams", developer: "Microsoft"),
        PotentialTechnology(name: "OneNote", developer: "Microsoft"),
        PotentialTechnology(name: "Microsoft Forms", developer: "Microsoft"),
        PotentialTechnology(name: "Microsoft Whiteboard", developer: "Microsoft"),
        PotentialTechnology(name: "Flipgrid", developer: "Microsoft"),
        PotentialTechnology(name: "Microsoft SharePoint", developer: "Microsoft"),
        PotentialTechnology(name: "Microsoft Math Solver", developer: "Microsoft"),
        PotentialTechnology(name: "Minecraft", developer: "Microsoft")
    ]
    
    static func suggestions(for partialSearch: String) -> [PotentialTechnology] {
        return partialSearch.isEmpty ? all : all.compactMap {
            if $0.name.lowercased().contains(partialSearch.lowercased()) {
                return ($0, Double(partialSearch.count) / Double($0.name.count))
            } else if ($0.developer?.lowercased() ?? "").contains(partialSearch.lowercased()) {
                return ($0, Double(partialSearch.count) / Double($0.developer!.count) / 2)
            } else {
                return nil
            }
        }
        .sorted(by: {
            $0.1 > $1.1
        })
        .map {
            $0.0
        }
    }
}
