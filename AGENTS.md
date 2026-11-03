# Repository Guide

## Purpose

This repository collects and processes public information about nuclear companies
for **nuclear security research**, storing source-backed records for a Power BI
dashboard.

The dashboard is built separately. Work in this repository focuses on preparing
the structured information it will consume.

## Research Focus

Prioritize physical protection, cybersecurity, nuclear material control and
accounting, safeguards and nonproliferation, fuel storage and transport security,
security by design, and security-related regulatory developments.

Use company profiles, reactor specifications, project status, and commercial
information as context for these questions. Keep nuclear safety, nuclear security,
and international safeguards distinct. Security findings must be tied to public
sources and the correct company, design, facility, and date.

## Instructions

Follow the parsing instructions in [instructions.md](instructions.md). Use the
[literature search prompt](literature_search_query.md) for requested research and
the full record template in [examples/structure.json](examples/structure.json).

Real company records belong under `data/`. The numbered company directories are
placeholders until company research is requested.

## Examples

Starter examples are in the [examples directory](examples/README.md). Each
example has its own subdirectory containing:

- `raw.md`: the original, unstructured text.
- `parsed.json`: the structured information extracted from that text.
