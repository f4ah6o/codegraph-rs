# Cargo release helpers.

crate_manifest := "crates/codegraph/Cargo.toml"

release-check:
    cargo test --all --all-features
    cargo build --release --all-features
    cargo publish --dry-run --locked --manifest-path {{crate_manifest}}

publish-cli: release-check
    cargo publish --locked --manifest-path {{crate_manifest}}

# Move the `latest` tag to HEAD to trigger the CalVer release workflow.
release-tag:
    git tag -f latest HEAD
    git push -f origin latest

release: release-check release-tag
