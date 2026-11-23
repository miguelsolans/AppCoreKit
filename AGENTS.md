# CoreKit - Agent Instructions

## Purpose

CoreKit provides reusable application infrastructure and foundational abstractions for iOS applications.

It contains base implementations and utilities designed to reduce repetitive application-level infrastructure code.

## Responsibilities

The package currently provides:

### Presentation
- BaseViewController
- BaseViewModel
- BaseCoordinator

### Resources
- PlistReader

### Networking
- BaseApiClient
- ApiClientConfiguration

These components must remain independent of individual application implementations.

## Architectural Principles

- Must remain application-independent.
- Must not contain Vault-specific functionality.
- Must not depend on VaultDomain.
- Must not depend on VaultCore.
- Must not depend on VaultData.
- Avoid unnecessary dependencies on UIKit outside presentation-related abstractions.

## Implementation Guidelines

- Keep abstractions generic and reusable.
- Avoid introducing functionality that only benefits a single consuming application.
- Prefer composition over unnecessary inheritance.
- Keep public APIs explicit and predictable.
- Preserve backwards compatibility where possible.
- Avoid premature abstractions.

## Existing Usage in Vault

Vault currently uses:

- BaseViewController
- BaseViewModel
- BaseCoordinator
- PlistReader

The remaining abstractions are available in the package but are not currently used by Vault.

Do not assume every available abstraction is actively adopted by the application.

## Known Technical Debt

BaseViewModel is not consistently adopted throughout Vault.

Its current design and usage require future review and potential refactoring.

Do not expand its adoption or introduce new dependencies on its lifecycle without first evaluating the existing implementation.

## Before Making Changes

Inspect the actual implementation and public APIs.

Evaluate whether proposed changes are generic enough to belong in CoreKit or should remain inside the consuming application.
