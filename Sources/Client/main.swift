import Template

let a = 17
let b = 25

let (result, code) = #stringify(a + b)

print("The value \(result) was produced by the code \"\(code)\"")

@addHelloWorldFunction
struct Greeter {}

Greeter.hello() // Prints: Hello, world!
