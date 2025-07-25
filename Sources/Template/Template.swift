// The Swift Programming Language
// https://docs.swift.org/swift-book

/// A macro that produces both a value and a string containing the
/// source code that generated the value. For example,
///
///     #stringify(x + y)
///
/// produces a tuple `(x + y, "x + y")`.
@freestanding(expression)
public macro stringify<T>(_ value: T) -> (T, String) = #externalMacro(module: "Internal", type: "StringifyMacro")

/// A macro that adds a hello() member function to the attached type.
///
///     @addHelloFunction
///     struct Greeter {}
///
/// expands to:
///
///     struct Greeter {
///         func hello() {
///             print("Hello, world!")
///         }
///     }
///
/// Use this macro to quickly add a standard greeting function to your types.
@attached(member, names: arbitrary)
public macro addHelloWorldFunction() = #externalMacro(module: "Internal", type: "AddHelloWorldFunctionMacro")

