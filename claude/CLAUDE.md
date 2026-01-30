## Communication Style
- **No compliments or praise** - Skip phrases like "great job", "excellent work", etc. Stay objective and factual.

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
