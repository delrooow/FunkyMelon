//
//  Menu.swift
//  FunkyMelon
//
//  Created by Stephen James Del Rosario on 7/1/25.
//

public enum MenuItem: CaseIterable, Identifiable {
    case discover
    case titles
    case effects
    case transitions
    case library
    
    public var id: String {
        switch self {
        case .discover:    "discover"
        case .titles:      "titles"
        case .effects:     "effects"
        case .transitions: "transitions"
        case .library:     "library"
        }
    }
    
    var displayName: String {
        switch self {
        case .discover:    "Discover"
        case .titles:      "Titles"
        case .effects:     "Effects"
        case .transitions: "Transitions"
        case .library:     "Library"
        }
    }
}

extension MenuItem {

    func assetName(isActive: Bool) -> String {
        switch self {
        case .discover:    return isActive ? "magnifyingglass.circle.fill" : "magnifyingglass.circle"
        case .titles:      return isActive ? "t.square.fill"               : "t.square"
        case .effects:     return isActive ? "moon.stars.circle.fill"      : "moon.stars.circle"
        case .transitions: return isActive ? "star.fill"                   : "star"
        case .library:     return isActive ? "folder.fill"                 : "folder"
        }
    }
}
