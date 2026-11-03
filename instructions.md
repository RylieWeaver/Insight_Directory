# Parsing Instructions

## Task

Take raw text about nuclear companies and format the information as JSON, with
**nuclear security as the primary research focus**. Use the complete record shape
in [examples/structure.json](examples/structure.json).

## Nuclear Security Focus

For this project, study public evidence about protecting nuclear materials,
facilities, and associated digital systems from malicious acts, including theft,
diversion, and sabotage. The [NRC security overview](https://www.nrc.gov/security)
provides background on physical protection, cybersecurity, and material controls.

Keep safety, security, and safeguards distinct in the records. Safety information
about accidents or equipment reliability is supporting context when relevant to a
security question. International safeguards concern verification of peaceful use
and support nonproliferation; see the
[DOE/NNSA safeguards overview](https://www.energy.gov/nnsa/nuclear-nexus-international-nuclear-safeguards).

Prioritize security evidence when selecting sources and summarizing a company.
Reactor specifications, ownership, licensing, partnerships, and funding provide
context for this analysis.

## Reactor Information

Use the following starter fields under `reactor_information`:

| Field | JSON key | Information to extract |
| --- | --- | --- |
| Reactor type | `reactor_type` | The reactor design or type stated in the text. |
| Thermal type | `thermal_type` | An explicitly labeled thermal type, if provided. Definition to be refined. |
| Spectrum | `spectrum` | The neutron spectrum stated in the text. |
| Coolant | `coolant` | The material used to cool the reactor. |
| Moderator | `moderator` | The material used as the moderator, or an explicit statement that none is used. |

## Nuclear Security Information

Use concise strings or `null` for the following fields under
`nuclear_security_information`:

| JSON key | Information to extract |
| --- | --- |
| `physical_protection` | Public descriptions of protection programs and their stated implementation status. |
| `cybersecurity` | Publicly documented cybersecurity governance, programs, and review status. |
| `material_control_and_accounting` | Public descriptions of nuclear material tracking, control, and accounting. |
| `safeguards_and_nonproliferation` | Applicable safeguards context, verification-related design work, and source-attributed nonproliferation findings. |
| `fuel_and_storage_security` | Protection and control during fuel handling and storage, including spent fuel where relevant. |
| `transport_security` | Public descriptions of protection and oversight for nuclear material transport. |
| `security_by_design` | Documented efforts to integrate security considerations into a reactor or facility design. |
| `security_regulatory_status` | Source-reported security-related submissions, reviews, approvals, or findings, with jurisdiction and date. |

Keep each summary at the public program or design level and identify the entity,
facility, or design it describes. Distinguish proposed measures, regulatory
requirements, company claims, and demonstrated implementation. Fuel security here
means material protection and control; fuel availability is commercial context.

### Evidence Rules

- Populate a security field only when a source supports the statement. Missing
  public disclosure is an information gap, not evidence of weak or strong security.
- Keep unsupported fields `null` and explain coverage gaps or conflicts in
  `record_metadata.notes`.
- Do not infer security performance, proliferation resistance, or safeguards
  compliance from reactor type, coolant, fuel form, enrichment, nationality, or
  general licensing status alone. Attribute assessments to their sources.
- Describe safety features separately unless a source explicitly connects them to
  a security function. Preserve the distinction between security by design and
  safeguards by design when a source discusses either.
- Record security-related regulatory status as reported by the relevant authority;
  a general framework or country-level agreement does not establish a company's
  compliance. Keep source, jurisdiction, design or facility, and date together.
- Use the existing `sources[].supported_fields` mechanism, with paths such as
  `nuclear_security_information.cybersecurity`. Avoid unsupported security scores
  or labels.

## Starter JSON Format

```json
{
  "reactor_information": {
    "reactor_type": null,
    "thermal_type": null,
    "spectrum": null,
    "coolant": null,
    "moderator": null
  },
  "nuclear_security_information": {
    "physical_protection": null,
    "cybersecurity": null,
    "material_control_and_accounting": null,
    "safeguards_and_nonproliferation": null,
    "fuel_and_storage_security": null,
    "transport_security": null,
    "security_by_design": null,
    "security_regulatory_status": null
  }
}
```

For these starter examples, use JSON `null` when the text does not provide a
value. Keep `thermal_type` separate from `spectrum`; do not infer one from the
other. An explicit statement that no moderator is used is a known value, not
missing information.

> **To refine:** Define thermal type and add more information fields later.

## Section Parsing Rules and Preferences

### Source Preferences

Prioritize government and regulatory sources, especially DOE/NNSA resources,
national laboratories, the applicable nuclear regulator, and IAEA publications.
Use official security and safeguards reviews, technical reports, peer-reviewed
research, and company disclosures relevant to the selected design or facility.
Use company statements with clear attribution and seek independent confirmation
for claimed implementation or performance.

## Examples

See the [three starter examples](examples/README.md) for raw text and its
corresponding parsed JSON. These examples are fictional and will be refined.
