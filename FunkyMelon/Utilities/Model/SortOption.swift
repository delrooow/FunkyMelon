//
//  SortOption.swift
//  FunkyMelon
//
//  Created by Stephen James Del Rosario on 7/1/25.
//

public enum SortOption: String, CaseIterable, Identifiable {
    case alphabetically     = "Alphabetical"
    case priceHighToLow     = "Price"
    case freeOnly           = "Free"
    case paidOnly           = "Paid"

    public var id: String { rawValue }
}
