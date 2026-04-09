# Git LFS Policy and Status

## Policy
- Do not use Git LFS unless binary or large-file artifacts require it.
- If LFS is needed, track only explicit patterns and document onboarding.
- If LFS is not needed, keep repository in standard git mode.

## When to Enable
- Model binaries or data samples exceed repository limits.
- Large assets are versioned and required in source control.

## When Not to Enable
- Assets can be generated in CI.
- Data can be stored in artifact/object storage outside git.

## Verification Commands
- `git lfs version`
- `git lfs ls-files`
- `git check-attr filter -- <file>`

## Expected Healthy State
- If not used: no LFS tracked files and no `.gitattributes` LFS patterns.
- If used: tracked patterns are minimal and documented.
