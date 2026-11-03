# Nuclear Security Literature Search and Company Record Refresh

Use this prompt once per company. A recurring workflow can apply it to the
maintained company list and pass JSON records for nuclear security research to
the Power BI ingestion process. Scheduling, storage, and dashboard refresh are
configured separately.

## Inputs

Replace the required company placeholder before running. Supply the optional
inputs when available.

- **Company:** `{{COMPANY_NAME}}` — required.
- **Official website or known aliases:** `{{WEBSITE_OR_ALIASES}}` — optional; helps
  identify the correct company.
- **Target reactor design:** `{{REACTOR_DESIGN}}` — optional; use the previous
  record's design when refreshing an existing record.
- **Research date:** `{{RESEARCH_DATE}}` — use the current date if omitted.
- **Previous JSON record:** `{{PREVIOUS_RECORD}}` — optional for the first run.
- **Last successful search date:** `{{LAST_SUCCESSFUL_SEARCH_DATE}}` — optional.

## Research Task

Perform a literature and web search on the specified nuclear company with
**nuclear security as the primary focus**. Collect public evidence about physical
protection, cybersecurity, material control and accounting, safeguards and
nonproliferation, fuel storage and transport security, security by design, and
security-related regulatory developments.

Use the company profile, reactor specifications, development and licensing status,
commercial relationships, and disclosed funding as supporting context. Produce a
complete, source-backed JSON record using the structure below.

When repository files are available, follow [instructions.md](instructions.md)
and the field names in [examples/structure.json](examples/structure.json). The
[starter examples](examples/README.md) illustrate extraction behavior; their
fictional content is not research evidence.

## Nuclear Security Research Priorities

- Look for publicly documented protection and cybersecurity programs, nuclear
  material accountancy, security-related design work, and regulatory reviews.
- Search for safeguards and nonproliferation research on the selected design,
  including safeguards by design where discussed. Keep safeguards verification,
  nuclear security, and accident-focused safety claims distinct.
- Cover fuel handling and storage, spent fuel where relevant, and transport
  security at the public program level. Keep fuel supply availability as context.
- Attribute each finding to the correct company, design, facility, jurisdiction,
  and date. Identify whether a measure is proposed, claimed, reviewed, approved,
  or implemented. Record documented evidence gaps and disagreements.
- Treat missing public information as unknown. Reactor specifications, fuel
  enrichment, a country's safeguards arrangements, or general licensing progress
  alone do not establish security performance or compliance. Use source-attributed
  assessments and keep unsupported security fields `null`.

## Search Approach

1. Confirm the company's identity, aliases, official website, and relevant reactor
   design. Separate similarly named companies and subsidiaries.
2. Prioritize government and regulatory sources, especially DOE/NNSA resources,
   relevant national laboratories, the applicable nuclear regulator, and IAEA
   publications on security and safeguards. Include
   peer-reviewed papers, technical reports, official company technical documents,
   regulatory filings, and company announcements. Use credible trade coverage to
   find additional evidence and fill gaps.
3. On the first run, search historical and recent material to establish a baseline.
   On later runs, search material published or updated since the last successful
   search and recheck time-sensitive claims, especially security-related reviews,
   public program updates, safeguards developments, licensing, and project
   milestones. Revisit older sources when needed to verify a field.
4. Open and inspect sources before using them. Search-result snippets, inaccessible
   documents, and the fictional examples do not establish facts. Record gaps in
   coverage rather than treating an unsuccessful search as evidence of no activity.
5. Match each claim to the correct design, project, location, and reporting date.
   Distinguish company statements, planned targets, regulatory approvals, and
   completed or operating projects.

## Extraction Rules

- Keep the exact JSON keys and nesting shown below. Populate unknown scalar values
  with `null` and lists with `[]` when no supported entries are available. Use an
  explicit value such as `"none"` for a confirmed absence, such as no moderator.
- Keep `target_applications`, `customers`, `partners`, and `supported_fields` as
  arrays of strings. Keep `sources` as an array of source objects and
  `record_metadata.notes` as a string or `null`. Each value under
  `nuclear_security_information` must be a concise string or `null`.
- Keep `thermal_type` distinct from `spectrum`. Its definition remains to be
  refined; populate it only when the source explicitly labels a thermal type.
- Use the selected design consistently. The current structure supports one reactor
  design per record. If several designs exist and no target or unambiguous primary
  design can be established, leave ambiguous reactor fields `null`, identify the
  candidates in `record_metadata.notes`, and mark the record `needs_review`.
- Use numbers for numeric fields and the units named in the keys. Record power per
  reactor module or unit, not an entire multi-module plant. Convert units only
  when the conversion is unambiguous. Describe unsupported ranges or ambiguous
  measurements in the notes instead of choosing an arbitrary number.
- Use `YYYY-MM-DD` for complete dates and four-digit integers for years. Keep
  incomplete or unknown dates `null` and preserve useful partial dates in notes.
  Record funding in its disclosed currency, with its scope in `funding_basis` and
  the reporting date in `funding_as_of_date`. Avoid double-counting announcements
  or treating proposed funding as secured funding.
- Resolve discrepancies using source authority, design identity, and the date the
  claim applies to. Explain unresolved conflicts in notes. Do not silently
  overwrite a supported value with a contradictory claim.

## Sources and Traceability

- Include only sources actually inspected, plus retained sources supporting facts
  carried forward from the previous record. Preserve existing source IDs and add
  unique IDs for new sources, such as `src_001`.
- For every populated research field, include at least one supporting source.
  List the relevant field paths in `supported_fields`, for example
  `reactor_information.coolant`, `development_information.licensing_status`, or
  `nuclear_security_information.cybersecurity`.
- Record the document title, publisher, source type, direct URL, publication date,
  and access date where available. Update an access date only when the source was
  actually reopened. Self-generated record metadata does not require a source.

## Recurring Updates

- Return a complete record on every run. Preserve previously supported facts and
  their sources when newer material omits them; replace a value only when the
  evidence supports the change.
- Prioritize changes affecting nuclear security and safeguards. Summarize material
  changes, unresolved conflicts, research gaps, and the search period in
  `record_metadata.notes`. State when no material changes were found.
- Set `record_type` to `"company_record"` and `last_updated_date` to the research
  date. Use `review_status` of `"ready"`, `"needs_review"`, or `"search_failed"`.
  `ready` means the record passes the checks below and has no unresolved material
  conflicts; unknown fields may still be `null`. Use `needs_review` when no
  reliable evidence is found, even if the search itself completed. If the company
  is identified but its security fields remain unsupported, use `needs_review`
  and describe which security topics lacked public evidence.
- If research access fails, retain the previous supported record, report the
  failure in its metadata, and mark it `search_failed`. A refresh failure must not
  erase the last successful record. The ingestion workflow should hold records
  marked `needs_review` or `search_failed` for review before replacing live data.
  On a failed first run with no previous record, return the full template shape,
  keep unsupported research fields `null` or empty, retain the requested company
  name as an input label, and explain the failure in the metadata.

## Output and Validation

Return exactly one complete JSON object, without Markdown fences or surrounding
commentary. Use the template as the output shape; replace its empty source stub
with actual source records, or use `[]` if none are available.

Before returning, verify that the JSON parses, all template keys are present,
numeric and date values follow the rules above, source IDs are unique, and every
populated research field has supporting evidence. The ingestion process consumes
this record for Power BI; this research output alone does not establish that a
dashboard refresh occurred.

## JSON Structure

```json
{
  "company_name": null,
  "company_information": {
    "legal_name": null,
    "website_url": null,
    "headquarters_country": null,
    "founded_year": null,
    "ownership_type": null,
    "stock_exchange": null,
    "stock_ticker": null,
    "summary": null
  },
  "reactor_information": {
    "design_name": null,
    "reactor_type": null,
    "thermal_type": null,
    "spectrum": null,
    "coolant": null,
    "moderator": null,
    "fuel_material": null,
    "fuel_form": null,
    "uranium_enrichment_percent_u235": null,
    "thermal_power_mwth": null,
    "electric_power_mwe": null,
    "outlet_temperature_c": null,
    "design_life_years": null,
    "refueling_interval_months": null
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
  },
  "development_information": {
    "development_stage": null,
    "technology_readiness_level": null,
    "regulatory_jurisdiction": null,
    "regulator": null,
    "licensing_status": null,
    "licensing_docket_number": null,
    "demonstration_site": null,
    "target_operation_year": null
  },
  "commercial_information": {
    "target_applications": [],
    "customers": [],
    "partners": [],
    "reported_funding_amount": null,
    "funding_currency": null,
    "funding_basis": null,
    "funding_as_of_date": null
  },
  "sources": [
    {
      "source_id": null,
      "title": null,
      "publisher": null,
      "source_type": null,
      "url": null,
      "publication_date": null,
      "accessed_date": null,
      "supported_fields": []
    }
  ],
  "record_metadata": {
    "record_type": "template",
    "last_updated_date": null,
    "review_status": null,
    "notes": null
  }
}
```
