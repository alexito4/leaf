import Async
import Dispatch
import Foundation
import Service
import TemplateKit

/// Used to configure Leaf renderer.
public struct LeafConfig: Service {
    let tags: [String: TagRenderer]
    let viewsDir: String
    let shouldCache: Bool

    public init(
        tags: [String: TagRenderer],
        viewsDir: String,
        shouldCache: Bool
    ) {
        self.tags = tags
        self.viewsDir = viewsDir
        self.shouldCache = shouldCache
    }
}

public final class LeafProvider: Provider {
    /// See Service.Provider.repositoryName
    public static let repositoryName = "leaf"

    public init() {}

    /// See Service.Provider.Register
    public func register(_ services: inout Services) throws {
        services.register(TemplateRenderer.self) { container -> LeafRenderer in
            let config = try container.make(LeafConfig.self, for: LeafRenderer.self)
            return LeafRenderer(
                config: config,
                on: container
            )
        }

        services.register { container -> LeafConfig in
            let dir = try container.make(DirectoryConfig.self, for: LeafRenderer.self)
            return LeafConfig(
                tags: defaultTags,
                viewsDir: dir.workDir + "Resources/Views",
                shouldCache: container.environment != .development
            )
        }
    }

    /// See Service.Provider.boot
    public func boot(_ container: Container) throws { }
}
