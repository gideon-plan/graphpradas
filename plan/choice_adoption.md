# Choice/Life Adoption Plan: graphpradas

## Summary

- **Error type**: `BridgeError` defined in lattice.nim -- move to `coloring.nim`
- **Files to modify**: 2 + re-export module
- **Result sites**: 1
- **Life**: Not applicable

## Steps

1. Delete `src/graphpradas/lattice.nim`
2. Move `BridgeError* = object of CatchableError` to `src/graphpradas/coloring.nim`
3. Add `requires "basis >= 0.1.0"` to nimble
4. In every file importing lattice:
   - Replace `import.*lattice` with `import basis/code/choice`
   - Replace `Result[T, E].good(v)` with `good(v)`
   - Replace `Result[T, E].bad(e[])` with `bad[T]("graphpradas", e.msg)`
   - Replace `Result[T, E].bad(BridgeError(msg: "x"))` with `bad[T]("graphpradas", "x")`
   - Replace return type `Result[T, BridgeError]` with `Choice[T]`
5. Update re-export: `export lattice` -> `export choice`
6. Update tests
