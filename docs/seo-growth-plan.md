# SEO and Growth Plan

## Goal

Make Device Sync for Snipe-IT show up when IT admins search for a Snipe-IT agent, Snipe-IT computer inventory sync, Snipe-IT Windows agent, Snipe-IT macOS agent, or Intune-to-Snipe-IT automation. The business goal is to fund development through sponsorships first, then validate whether a paid support, signed-build, hosted connector, or acquisition path makes sense.

## Positioning

Primary message:

Device Sync for Snipe-IT is an independent, self-hosted Snipe-IT agent for Windows and macOS computer inventory. It keeps hardware assets current by syncing serial number, model, hostname, operating system, network details, optional software inventory, custom fields, and user assignment through the Snipe-IT API.

Short description for GitHub:

Independent Snipe-IT agent for Windows and macOS inventory sync, with Intune packaging, custom fields, software inventory, and user assignment.

One-line offer:

Keep Snipe-IT computer assets current without building your own endpoint inventory script.

## Search Intent

High-intent phrases:

- snipe-it agent
- snipe it agent
- snipe-it windows agent
- snipe-it mac agent
- snipe-it macos agent
- snipe-it inventory agent
- snipe-it computer inventory
- snipe-it asset discovery
- snipe-it endpoint inventory
- intune snipe-it integration
- intune to snipe-it
- sync computers to snipe-it
- auto inventory snipe-it
- snipe-it software inventory
- snipe-it powershell agent

Pain-language phrases:

- Does Snipe-IT have an agent?
- How do I automatically add computers to Snipe-IT?
- Can Snipe-IT inventory Windows computers?
- Can Intune sync devices to Snipe-IT?
- How do I keep Snipe-IT assets up to date?
- Snipe-IT manual asset entry automation

## GitHub SEO Checklist

- Repository name: keep `snipe-it-agent`.
- Repository description: use the short description above.
- Website URL: point to either the public landing page or GitHub Sponsors until a landing page exists.
- Topics: `snipe-it`, `snipeit`, `itam`, `asset-management`, `inventory-agent`, `windows-agent`, `macos-agent`, `intune`, `endpoint-inventory`, `dotnet`.
- README H1: include `Snipe-IT Agent` near the front.
- README opening paragraph: include `Snipe-IT agent`, `computer inventory sync`, `Windows`, `macOS`, and `Intune`.
- Releases: write release titles like `Device Sync for Snipe-IT v0.1.x - Windows Snipe-IT Agent and Intune Package`.
- Issues: label beginner-friendly tasks that improve trust, such as signing, tests, docs, and least-privilege API permissions.

## Content Roadmap

Create one focused page per search intent. Keep each page practical, with setup steps, screenshots, warnings, and links to the release.

- `Snipe-IT Agent for Windows`: service install, inventory fields, dry run, logs.
- `Deploy a Snipe-IT Agent with Microsoft Intune`: Win32 app setup, detection rule, configuration, rollout.
- `Snipe-IT Agent for macOS`: launch daemon, setup app, config path, troubleshooting.
- `Automatically Add Computers to Snipe-IT`: serial matching, asset creation, model resolution, custom fields.
- `Snipe-IT Software Inventory`: what is collected, limitations, custom field strategy.
- `Snipe-IT API Token Permissions for Inventory Agents`: least-privilege guidance and security tradeoffs.
- `Snipe-IT Agent vs Intune Sync`: when to use endpoint-side sync, Graph-side sync, or both.
- `Snipe-IT Agent FAQ`: answer the exact questions from admins evaluating automation.

## Conversion Path

Current conversion:

- README and docs lead to GitHub Releases.
- README and docs lead to GitHub Sponsors.
- Issues and discussions capture feature requests and deployment blockers.

Near-term paid offers:

- Sponsored development tiers.
- Paid setup support for Intune packaging and Snipe-IT custom fields.
- Signed Windows and macOS builds for sponsors or customers.
- Priority compatibility testing against specific Snipe-IT versions.

Potential product offers:

- Enrollment service that avoids shipping long-lived API tokens to every endpoint.
- Central health dashboard for last sync, failures, stale devices, and agent version.
- Hosted connector for organizations that want automation without operating middleware.
- Enterprise package with signed installers, support SLA, deployment templates, and upgrade tooling.

## Snipe-IT Ecosystem Strategy

Stay clearly independent and respectful of Snipe-IT trademark boundaries. Use phrases like `for Snipe-IT`, `compatible with Snipe-IT`, and `independent Snipe-IT integration`; avoid implying official endorsement.

Make the project attractive to the Snipe-IT maintainers by reducing repeated community pain:

- Keep API usage clean and documented.
- Document field mappings and least-privilege permissions.
- Add tests around duplicate prevention and asset matching.
- Publish clear security limitations and a plan to fix them.
- Collect public evidence that users want an installable endpoint inventory agent.

If acquisition ever becomes realistic, the useful story is not just traffic. It is adoption, supportability, clean architecture, tested API behavior, and proof that this closes a long-standing product gap for Snipe-IT users.

## Measurement

Track monthly:

- GitHub stars, forks, watchers, release downloads, and sponsor clicks.
- Search impressions and clicks for the primary phrases once a landing page is connected to Search Console.
- Issues opened by real admins trying deployment.
- Completed installs reported by users or sponsors.
- Conversion from docs to release downloads and sponsorship.

## Next Actions

1. Update GitHub repository description and topics.
2. Publish a simple landing page using the positioning and FAQ.
3. Add screenshots or terminal captures for Windows setup, `inventory`, `test`, `sync --dry-run`, service install, and Intune detection.
4. Create the first two intent pages: Windows agent and Intune deployment.
5. Add a sponsor tier that names concrete deliverables: signed builds, security hardening, and compatibility testing.
6. Ask for inclusion or updated placement in Snipe-IT community integration lists after the README, releases, and security notes are polished.
