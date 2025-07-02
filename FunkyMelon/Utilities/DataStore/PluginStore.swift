//
//  PluginStore.swift
//  FunkyMelon
//
//  Created by Stephen del Rosario on 7/1/25.
//

import SwiftUI

enum LoadState {
    case idle
    case loading
    case success(PluginList)
    case failure(Error)
}

@MainActor
final class PluginStore: ObservableObject {
    @Published private(set) var state: LoadState = .idle
    
    @Published var installing:   Set<UUID> = []
    @Published var updating:     Set<UUID> = []
    @Published var uninstalling: Set<UUID> = []
    @Published var progress:     [UUID: Double] = [:]

    func load() {
        state = .loading
        do {
            let plugins = try Bundle.main.loadPlugins(from: "plugins.json")
            state = .success(plugins)
        } catch {
            state = .failure(error)
        }
    }
    
    func install(pluginID id: UUID)  {
        start(.install, id)
    }
    
    func update(pluginID id: UUID)   {
        start(.update, id)
    }
    
    func uninstall(pluginID id: UUID) {
        start(.uninstall, id)
    }
    
    private func start(_ kind: Mutation, _ id: UUID) {
        guard case .success(let list) = state,
              let item = list.first(where: { $0.id == id }) else { return }

        switch kind {
        case .install
            where item.free && !item.installed: installing.insert(id)
        case .update
            where item.installed && item.requiresUpdate: updating.insert(id)
        case .uninstall
            where item.installed: uninstalling.insert(id)
        default:
            return
        }

        progress[id] = 0
        
        Task {
            await runProgress(
                for: id,
                kind: kind
            )
        }
    }
}

private extension PluginStore {

    enum Mutation {
        case install, update, uninstall
    }

    func runProgress(for id: UUID, kind: Mutation) async {

        for step in 1...20 {                             
            try? await Task.sleep(nanoseconds: 100_000_000)
            progress[id] = Double(step) / 20
        }

        guard case .success(var list) = state,
              let idx = list.firstIndex(where: { $0.id == id })
        else {
            clean(id); return
        }

        switch kind {
        case .install:
            list[idx] = list[idx].copy(withInstalled: true)
        case .update:
            list[idx] = list[idx].copy(bumpingPatch: true)
        case .uninstall:
            list[idx] = list[idx].copy(withInstalled: false)
        }

        state = .success(list)
        clean(id)
    }

    func clean(_ id: UUID) {
        installing.remove(id);
        updating.remove(id);
        uninstalling.remove(id)
        progress[id] = nil
    }
}

private extension Plugin {

    func copy(withInstalled flag: Bool) -> Plugin {
        Plugin(
            id: id,
            category: category,
            title: title,
            subtitle: subtitle,
            description: description,
            includes: includes,
            guides: guides,
            price: price,
            free: free,
            installed: flag,
            requiresUpdate: flag ? requiresUpdate : false,
            version: version,
            iconAsset: iconAsset,
            heroAsset: heroAsset,
            lastUsed: flag ? Date() : nil
        )
    }

    func copy(bumpingPatch: Bool) -> Plugin {
        let parts = version.split(separator: ".").map { Int($0) ?? 0 }
        var bump  = parts; if let i = bump.indices.last { bump[i] += 1 }
        
        return Plugin(
            id: id,
            category: category,
            title: title,
            subtitle: subtitle,
            description: description,
            includes: includes,
            guides: guides,
            price: price,
            free: free,
            installed: installed,
            requiresUpdate: false,
            version: bump.map(String.init).joined(separator: "."),
            iconAsset: iconAsset,
            heroAsset: heroAsset,
            lastUsed: lastUsed
        )
    }
}
