import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import Testing

@testable import Template

#if canImport(Internal)
    import Internal
    let macros: [String: Macro.Type] = [
        "stringify": StringifyMacro.self
    ]
#else
    let macros: [String: Macro.Type] = [:]
#endif

@Test("Import") func external() async throws {
    #if canImport(Internal)
    #else
        #error("Macros are only supported when running tests for the host platform.")
    #endif
}

@Suite("Tests") enum Tests {}

extension Tests {
    @Suite("Tests.Expansion") struct Expansion {}
}

extension Tests.Expansion {
    @Test("Tests.Expansion.Baseline") func baseline() async throws {
        let source = """
            #stringify(a + b)
            """

        let expectation = """
            (a + b, "a + b")
            """

        assertMacroExpansion(source, expandedSource: expectation, macros: macros)
    }
}

extension Tests.Expansion {
    @Test("Tests.Expansion.String-Literal") func literal() async throws {
        let literal = #"""
            #stringify("Hello, \(name)")
            """#

        let expectation = #"""
            ("Hello, \(name)", #""Hello, \(name)""#)
            """#

        assertMacroExpansion(literal, expandedSource: expectation, macros: macros)
    }
}
