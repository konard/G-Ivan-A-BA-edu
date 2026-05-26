#!/usr/bin/env python3
"""Render classification-tz.md to HTML using the same shell/style as classification.html."""
from pathlib import Path

import markdown

SRC = Path("research/mango/classification-tz.md")
DST = Path("research/mango/classification-tz.html")

TEMPLATE = """<!doctype html>
<html lang="ru">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Классификация требований по корпусу ТЗ (classification (TZ))</title>
  <style>
    :root {{
      color-scheme: light;
      --bg: #f6f7f9;
      --paper: #ffffff;
      --text: #1f2933;
      --muted: #5f6b7a;
      --line: #d8dee8;
      --accent: #1f6feb;
      --head: #eef3fb;
    }}
    * {{ box-sizing: border-box; }}
    body {{
      margin: 0;
      background: var(--bg);
      color: var(--text);
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Arial, sans-serif;
      line-height: 1.55;
    }}
    main {{
      max-width: 1180px;
      margin: 0 auto;
      padding: 32px 20px 56px;
    }}
    article {{
      background: var(--paper);
      border: 1px solid var(--line);
      border-radius: 8px;
      padding: 32px;
      box-shadow: 0 10px 28px rgba(31, 41, 51, 0.06);
    }}
    h1 {{
      margin-top: 0;
      font-size: clamp(28px, 4vw, 42px);
      line-height: 1.15;
    }}
    h2 {{
      margin-top: 36px;
      padding-bottom: 8px;
      border-bottom: 1px solid var(--line);
    }}
    h3 {{ margin-top: 28px; }}
    p, li {{ font-size: 16px; }}
    a {{ color: var(--accent); }}
    table {{
      width: 100%;
      border-collapse: collapse;
      margin: 18px 0 28px;
      font-size: 14px;
    }}
    th, td {{
      border: 1px solid var(--line);
      padding: 10px 12px;
      vertical-align: top;
    }}
    th {{
      background: var(--head);
      text-align: left;
      font-weight: 700;
    }}
    tr:nth-child(even) td {{ background: #fbfcfe; }}
    code {{
      background: #edf2f7;
      border-radius: 4px;
      padding: 2px 5px;
      font-family: ui-monospace, SFMono-Regular, Menlo, Consolas, monospace;
      font-size: 0.92em;
    }}
    strong {{ color: #1f2933; }}
    @media (max-width: 760px) {{
      main {{ padding: 16px 10px 32px; }}
      article {{ padding: 20px 14px; }}
      table {{ display: block; overflow-x: auto; white-space: normal; }}
      th, td {{ min-width: 180px; }}
    }}
  </style>
</head>
<body>
  <main>
    <article>
{body}
    </article>
  </main>
</body>
</html>
"""


def main() -> None:
    md_text = SRC.read_text(encoding="utf-8")
    body = markdown.markdown(
        md_text,
        extensions=["tables", "fenced_code", "sane_lists", "toc"],
        output_format="html5",
    )
    html = TEMPLATE.format(body=body)
    DST.write_text(html, encoding="utf-8")
    print(f"wrote {DST} ({len(html)} chars)")


if __name__ == "__main__":
    main()
