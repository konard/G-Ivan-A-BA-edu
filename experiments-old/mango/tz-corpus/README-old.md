# TZ corpus extraction scripts

Reproducible pipeline for `research/mango/classification-tz.md`.

## Files

- `urls.txt` — 30 TZ source URLs from issue #9, one per line: `index ext url`.
- `extract_docx.py` — extracts text from `.docx` (python-docx) and `.xlsx` (openpyxl) into `text/*.txt`. `.doc` files are not handled here; convert them with `catdoc -d utf-8` separately (LibreOffice is not required).
- `build_html.py` — renders `research/mango/classification-tz.md` to `research/mango/classification-tz.html` using the same shell/style as `classification.html`.
- `.gitignore` — excludes downloaded source files and extracted text from version control.

## Reproduce

```sh
# from repo root
pip install --user python-docx openpyxl markdown

mkdir -p experiments/mango/tz-corpus/files experiments/mango/tz-corpus/text
while read idx ext url; do
  curl -L -H "Authorization: token $(gh auth token)" \
    -o "experiments/mango/tz-corpus/files/${idx}.${ext}" "${url}"
done < experiments/mango/tz-corpus/urls.txt

# .doc files (4, 17) — convert manually
catdoc -d utf-8 experiments/mango/tz-corpus/files/4.doc  > experiments/mango/tz-corpus/text/4.txt
catdoc -d utf-8 experiments/mango/tz-corpus/files/17.doc > experiments/mango/tz-corpus/text/17.txt

cd experiments/mango/tz-corpus
python3 extract_docx.py
cd ../../..
python3 experiments/mango/tz-corpus/build_html.py
```
