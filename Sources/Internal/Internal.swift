import SwiftCompilerPlugin
import SwiftDiagnostics
import SwiftOperators
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacroExpansion
import SwiftSyntaxMacros

private typealias Exception = SwiftSyntaxMacros.MacroExpansionErrorMessage

/// Implementation of the `stringify` macro, which takes an expression
/// of any type and produces a tuple containing the value of that expression
/// and the source code that produced the value. For example
///
///     #stringify(x + y)
///
///  will expand to
///
///     (x + y, "x + y")
public struct StringifyMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) -> ExprSyntax {
        guard let argument = node.arguments.first?.expression else {
            fatalError("compiler bug: the macro does not have any arguments")
        }

        return "(\(argument), \(literal: argument.description))"
    }
}

public struct AddHelloWorldFunctionMacro: MemberMacro, PeerMacro, Sendable {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let member = declaration.as(StructDeclSyntax.self) else {
            context.diagnose(
                Diagnostic(
                    node: declaration,
                    message: Exception(
                        "'@HelloWorldFunction' can only be applied to struct types"
                    )
                )
            )

            return []
        }

        // Create a function declaration for: func hello() { print("Hello, world!") }
        //        let helloFunc = try? FunctionDeclSyntax("func hello() { print(\"Hello, world!\") }")
        //        return [DeclSyntax(helloFunc)]
        return [
            """
            public static func hello() { print("Hello World") }
            """
        ]
    }

    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        // The peer macro expansion of this macro is only used to diagnose misuses
        // on symbols that are not decl groups.

        return []
    }

    public static var formatMode: FormatMode {
        .disabled
    }
}

@main
struct Plugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        StringifyMacro.self,
        AddHelloWorldFunctionMacro.self,
    ]
}
