import Async
import Bits
import Dispatch
import Foundation
import Service
import TemplateKit

/// Renders Leaf templates using the Leaf parser and serializer.
public final class LeafRenderer: ViewRenderer, TemplateRenderer, Service {
    /// See TemplateRenderer.parser
    public var parser: TemplateParser

    /// See TemplateRenderer.astCache
    public var astCache: ASTCache?

    /// See TemplateRenderer.templateFileEnding
    public var templateFileEnding: String {
        return ".leaf"
    }

    /// The tags available to this renderer.
    public let tags: [String: TagRenderer]

    /// Views base directory.
    public let relativeDirectory: String

    /// The event loop this leaf renderer will use
    /// to read files and cache ASTs on.
    public let container: Container

    /// Create a new Leaf renderer.
    public init(config: LeafConfig, using container: Container) {
        self.tags = config.tags.storage
        astCache = config.shouldCache ? .init() : nil
        self.container = container
        self.relativeDirectory = config.viewsDir.finished(with: "/")
        self.parser = LeafParser()
    }
}
