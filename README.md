# Insight Dashboard

Collect and structure public information about nuclear companies for
**nuclear security research** in Power BI.

## Research Focus

Prioritize physical protection, cybersecurity, nuclear material control and
accounting, safeguards and nonproliferation, fuel storage and transport security,
security by design, and security-related regulatory developments. Company and
reactor information provides context for these questions.

Findings are source-backed, with unknowns and evidence gaps retained explicitly.
See the [parsing instructions](instructions.md) for field definitions.

## Project Documents

- [Repository guide](AGENTS.md)
- [Parsing instructions](instructions.md)
- [Literature search prompt](literature_search_query.md)
- [Starter examples](examples/README.md)

## Preview Markdown Locally

Use [MkDocs](https://www.mkdocs.org/) to view the Markdown as a documentation
website, with formatted headings, tables, code blocks, and navigation between
pages.

If the previous preview server is still running, press **Ctrl+C** in its terminal
first. Then run:

```sh
cd ~/Coding/Projects/Insight_Dashboard
sh preview.sh
```

The command opens [http://localhost:8000/](http://localhost:8000/) in your browser.
Use the navigation menu or links within a document to browse rendered pages,
including the nested examples. The preview reloads when you save Markdown edits.

This uses the `uv` tool already available on this machine. The first run downloads
MkDocs and its dependencies. Press **Ctrl+C** in the terminal to stop the server.
