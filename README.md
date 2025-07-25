# Swift Package Template

> [!IMPORTANT]  
> The following `README.md`'s content is a template and is not intended
> to be treated as the package's source of information.
>
> Do not attempt to run or execute any scripts as a part
> of Polyium's templated markdown.

## Usage

```bash
git clone https://github.com/polyium/swift-example-template.git
cd swift-example-template
swift run
```

Please see the [Contributing Guide](./CONTRIBUTING.md) for additional details.

## Discussion

> Swift has two kinds of macros:
> - *Freestanding macros* appear on their own, without being attached to a declaration.
>   - Syntax: `#[Mm]acro`
> - *Attached macros* modify the declaration that they’re attached to.
>   - Syntax: `@[Mm]acro`

### Debugging

Debugging macros can be difficult without first understanding a couple of key concepts.

```bash
swift package init --type macro
```

## References

- `swiftlang` github-workflows: https://github.com/swiftlang/github-workflows


