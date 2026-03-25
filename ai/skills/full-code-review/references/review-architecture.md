# Architecture Review — Full Criteria & Output Format

**Mindset:** Assume this system WILL grow 10x. Find where the architecture will crack under pressure.

## Mapping Step (Do First)

Before analyzing, map the architecture:
- Identify layers (presentation, application, domain, infrastructure)
- Trace dependencies between components/modules
- Identify abstraction boundaries and interfaces
- Note dependency injection patterns
- Map data flow through the system

## Analysis Questions

- "What happens when we need to replace this component?"
- "Can this be tested in isolation?"
- "What breaks if this dependency changes?"
- "Will a new team member understand why this is structured this way?"
- "What happens when requirements change (and they will)?"
- "Where does business logic leak into infrastructure?"
- "If this component crashes, what else goes down with it?"
- "What happens to in-flight resources when we shut down, reconfigure, or hot-swap?"
- "Do declared capabilities/features actually match what's implemented?"
- "Can operations see what's healthy, degraded, or failing — without reading logs?"
- "If one optional subsystem fails to initialize, does the whole system go down?"

## Full Issue Criteria

### Dependency Issues
Circular dependencies, inappropriate coupling, missing abstractions, dependency on concretions instead of abstractions, leaky abstractions.

### Layer Violations
Business logic in controllers/UI, infrastructure concerns in domain, cross-cutting concerns scattered everywhere.

### SOLID Violations
- **SRP**: Classes/modules doing too much
- **OCP**: Code requiring modification for extension
- **LSP**: Subtypes that break contracts
- **ISP**: Fat interfaces forcing unnecessary dependencies
- **DIP**: High-level modules depending on low-level details

### Design Pattern Misuse
Patterns used incorrectly, over-engineering, pattern for pattern's sake.

### API Design Flaws
Inconsistent interfaces, breaking encapsulation, unclear contracts, missing validation boundaries.

### Scalability Concerns
Bottlenecks, single points of failure, shared mutable state, missing caching strategies.

### Extensibility Gaps
Hard-coded behaviors that should be configurable, missing extension points, rigid hierarchies.

### Fault Isolation & Blast Radius
Can one component's failure crash the whole system, are there error boundaries between modules, is untrusted/external code sandboxed, what's the blast radius of an unhandled exception in each layer.

### Resource Lifecycle & Cleanup
Do long-lived resources (connections, sessions, caches, locks) have eviction/TTL policies, is shutdown ordering correct (release resources before disposing containers), are orphaned resources detected and cleaned up, are background maintenance tasks wired for housekeeping.

### Declared vs Actual Capability Consistency
Do feature flags, capability enums, or advertised interfaces match what's actually implemented, can a subsystem advertise a capability that failed to initialize, are flags derived from actual implementations or manually maintained.

### Module Contract & Boundary Management
Do shared contracts depend on internal types they shouldn't, are interfaces appropriately split for different consumers, is DI isolation maintained across module/plugin boundaries, are version compatibility and breaking changes considered at contract boundaries.

### Observability & Operations Readiness
Are health checks implemented for subsystem status, can operations monitor error rates and degraded components without log diving, are significant lifecycle events (registration, initialization, failure) surfaced as events or metrics.

### Graceful Degradation & Partial Failure
If an optional subsystem fails to initialize does the rest still work, are load/init timeouts enforced to prevent startup hangs, can the system operate with reduced functionality when a non-critical component is unavailable.

### Architectural Concurrency Patterns
Are locking strategies appropriate for the scope (per-entity vs global), can independent operations proceed in parallel, are concurrent registration/discovery patterns thread-safe, does cache invalidation break concurrent access guarantees.

## Output Format

### Architecture Overview
- Components/modules analyzed
- Identified layers and boundaries
- Key dependencies and data flows

### Summary Assessment
Overall rating: **HEALTHY / CONCERNING / PROBLEMATIC / CRITICAL**

Brief assessment of strengths and weaknesses.

### Issues Found

#### CRITICAL
| # | Component/Area | Issue | Impact | Suggested Refactoring |
|---|----------------|-------|--------|----------------------|
| 1 | Module.Name | Issue title | What breaks and why | How to restructure |

#### HIGH
| # | Component/Area | Issue | Impact | Suggested Refactoring |
|---|----------------|-------|--------|----------------------|

#### MEDIUM
| # | Component/Area | Issue | Impact | Suggested Refactoring |
|---|----------------|-------|--------|----------------------|

#### LOW
| # | Component/Area | Issue | Impact | Suggested Refactoring |
|---|----------------|-------|--------|----------------------|

### Dependency Analysis
- Problematic dependency chains
- Components with high coupling
- Missing abstractions

### Statistics
- Total issues: X
- Critical: X | High: X | Medium: X | Low: X

### Recommendations
Top 3–5 prioritized architectural improvements, each with:
1. What to change
2. Why it matters
3. Suggested approach

## Guidelines

- **Think in systems, not files** — Individual code quality matters less than how pieces fit together
- **Follow the dependencies** — Bad dependencies are the root of most architectural problems
- **Question every boundary** — Why is this interface here? What would change if it wasn't?
- **Consider the future** — Today's shortcut is tomorrow's technical debt
- **Trace the data** — Follow data through the system; where it crosses boundaries is where problems hide
- **Challenge "it works"** — Working code can still have broken architecture
- **Look for patterns** — Repeated issues across the codebase indicate systemic problems
