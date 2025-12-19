# Contributing

Thanks for wanting to help improve this Active Directory lab repo!

## Simple ways to contribute
- Fix typos or make instructions clearer for beginners
- Improve script safety (validation, better error messages)
- Add new lab scripts (GPOs, shares, DHCP, etc.)

## How to contribute
1. Fork the repo
2. Create a branch: `feature/your-change`
3. Commit your changes with a clear message
4. Open a Pull Request

## Script style guidelines
- Prefer parameters over hard-coded values
- Use `-WhatIf` support (`SupportsShouldProcess`) for scripts that change AD
- Add comment-based help (`.SYNOPSIS`, `.DESCRIPTION`, `.EXAMPLE`)
