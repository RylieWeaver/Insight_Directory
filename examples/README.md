# Starter Examples

These three fictional examples demonstrate the current raw-text-to-JSON
format. They are illustrative fixtures, not verified company or reactor
records. We will refine the content and fields later.

The project focuses on nuclear security. These initial raw texts contain reactor
specifications without security evidence, so each parsed example includes
`nuclear_security_information` with all fields set to `null`. This demonstrates
how to preserve evidence gaps without inferring a security assessment from the
reactor's technical characteristics.

The [full company record template](structure.json) includes company context,
reactor specifications, nuclear security information, and source metadata.

## Example Pairs

| Example | Focus | Raw text | Parsed JSON |
| --- | --- | --- | --- |
| 01 — Water-cooled | All five fields explicitly stated | [raw.md](01-water-cooled/raw.md) | [parsed.json](01-water-cooled/parsed.json) |
| 02 — Gas-cooled | Alternate coolant and moderator; thermal type omitted | [raw.md](02-gas-cooled/raw.md) | [parsed.json](02-gas-cooled/parsed.json) |
| 03 — Partial data | Missing values retained as `null` | [raw.md](03-partial-data/raw.md) | [parsed.json](03-partial-data/parsed.json) |

## Directory Layout

```text
examples/
├── README.md
├── structure.json
├── 01-water-cooled/
│   ├── raw.md
│   └── parsed.json
├── 02-gas-cooled/
│   ├── raw.md
│   └── parsed.json
└── 03-partial-data/
    ├── raw.md
    └── parsed.json
```

Every parsed record uses the same five keys under `reactor_information` and the
same security fields under `nuclear_security_information`. These are partial
extraction examples; use [structure.json](structure.json) for complete company
records. Missing information is represented by JSON `null`. In the first example,
`thermal_type` is copied from an explicit label in the fictional source;
it is not inferred from the neutron spectrum.

Refer to the [parsing instructions](../instructions.md) when refining these
examples.
