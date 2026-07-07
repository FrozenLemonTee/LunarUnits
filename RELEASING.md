# Releasing

LunarUnits is published to [mooncakes.io](https://mooncakes.io). The CI workflow
(`.github/workflows/ci.yml`) runs `moon check`, `moon info`, `moon fmt` and
`moon test` on every push and pull request, so a release only needs the publish
checklist below.

## Checklist

1. Make sure `master` is green in CI.
2. Bump the version in `moon.mod` (`version = "x.y.z"`), following [semantic
   versioning](https://semver.org).
3. Update `README.md` / `README_zh.md` and `docs/` if the public surface
   changed.
4. From a clean checkout on `master`, run the pre-publish checks:

   ```
   moon check --target all
   moon info
   git diff --exit-code
   moon fmt --check
   moon test --target all
   ```

   `moon info` must leave the working tree unchanged, `moon fmt --check` must pass
   (CI enforces the same), and all checks must pass.
5. Publish:

   ```
   moon publish
   ```

6. Tag the release and push the tag:

   ```
   git tag vx.y.z
   git push --tags
   ```

## Optional: coverage

To inspect which lines are not yet exercised by tests:

```
moon test --enable-coverage
moon coverage analyze
```
