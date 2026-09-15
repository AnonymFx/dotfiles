# Communication Style
- **No compliments or praise** - Skip phrases like "great job", "excellent work", etc. Stay objective and factual.
- If something is not clear, ask follow up questions instead of assuming things.
- Don't invent jargon, use the terminology that's already present in the codebase or in your prompt.

# Coding Guidelines
- **Return outputs; never pass them as parameters.** A method's results belong in its return value, not in a collection or builder handed in as an argument to be filled (no "output parameters"). When a method must produce several outputs, return a small (local) record rather than mutating caller-provided arguments. Accumulating into a method's own local variables, or into instance fields that represent run state, is fine — the rule is specifically about not writing results into parameters.
- **Documentation comments**: In doc comments, only explain what's relevant for the user of a method or class, no internals and no (current) usages. Only document private methods if it's not obvious what they do, so documenting private methods should be the exception.

## Java Code Style Preferences
### Ternary Operator
- **Avoid using the ternary operator** in general
- **Preferred alternatives:**
  - Use `Objects.requireNonNullElse()` or `Objects.requireNonNullElseGet()` for null checks
  - Use `Optional.ofNullable()` with `.orElse()` or `.orElseGet()` for optional values
  - Extract a small method to initialize the variable with clear, descriptive logic
  - Use explicit if-else statements for better readability
### Other guidelines
- **Prefer imports over fully qualified names**
- **Use static imports for:**
  - Static methods in utility classes (e.g., `import static org.assertj.core.api.Assertions.assertThat;`)
  - Enum constants (e.g., `import static com.teamscale.EStatus.SUCCESS;`)
- **Do NOT use `var` for local variables** - Prohibited by coding guidelines
- **Prefer modern Java features** when they improve code clarity and maintainability
- **Introduce local record classes** instead of complex generic data types
- **Use enum types** instead of boolean parameters for method behavior switches
