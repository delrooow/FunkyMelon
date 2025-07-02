//
//  Plugin.swift
//  FunkyMelon
//
//  Created by Stephen del Rosario on 6/30/25.
//

import Foundation
import SwiftUI

// MARK: - Convenience type-alias
public typealias PluginList = [Plugin]

// MARK: - Plugin
public struct Plugin: Identifiable, Codable, Equatable, Hashable {
    public let id:             UUID
    public let category:       PluginCategory
    public let title:          String
    public let subtitle:       String
    public let description:    String

    public let includes:       [String]
    public let guides:         [URL]
 
    public let price:          PluginPrice
    public let free:           Bool
    public let installed:      Bool
    public let requiresUpdate: Bool
    public let version:        String

    public let iconAsset:      String
    public let heroAsset:      String

    public let lastUsed:       Date?
}

// MARK: - PluginCategory
public enum PluginCategory: String, Codable, CaseIterable {
    case titles =      "Titles"
    case effects =     "Effects"
    case transitions = "Transitions"
    
}

// MARK: - Plugin Price & Currency
public struct PluginPrice: Codable, Equatable, Hashable {
    public let amount:   Double
    public let currency: Currency
}

public enum Currency: String, Codable {
    case usd = "USD"
}

// MARK: - JSON loading helper
public extension Bundle {
    func loadPlugins(
        from filename: String,
        dateDecoding: JSONDecoder.DateDecodingStrategy = .iso8601
    ) throws -> PluginList {

        guard let url = url(forResource: filename, withExtension: nil) else {
            throw CocoaError(.fileReadNoSuchFile, userInfo: [NSURLErrorKey: filename])
        }
        return try Self.decodePlugins(from: url, dateDecoding: dateDecoding)
    }

    static func decodePlugins(
        from url: URL,
        dateDecoding: JSONDecoder.DateDecodingStrategy = .iso8601
    ) throws -> PluginList {

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecoding
        return try decoder.decode(PluginList.self, from: data)
    }
}

// MARK: - Helpers
public extension Plugin {
    var iconImage: Image { Image(iconAsset) }
    var heroImage: Image { Image(heroAsset) }
}

extension Plugin {
    
    static let sample = Plugin(
        id: UUID(),
        category: .titles,
        title: "Caption Pop AI",
        subtitle: "Automatic AI captions for Final Cut Pro",
        description: "Demo description",
        includes: ["10 presets", "Lifetime updates"],
        guides: [],
        price: PluginPrice(amount: 49, currency: .usd),
        free: false,
        installed: false,
        requiresUpdate: false,
        version: "1.0.0",
        iconAsset: "plugin-transitions-nebula-roll",
        heroAsset: "plugin-transitions-nebula-roll",
        lastUsed: nil
    )
}
