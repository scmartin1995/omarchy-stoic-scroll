# Sources

Every quotation in `Quotes.js` is an excerpt from a public-domain English
translation and appears verbatim in the edition below. Excerpts may start or
end mid-sentence; nothing is paraphrased or reworded.

| Author | Work | Translator | Edition used |
|---|---|---|---|
| Marcus Aurelius | *Meditations* (Thoughts of Marcus Aurelius Antoninus) | George Long | [Project Gutenberg #15877](https://www.gutenberg.org/ebooks/15877) |
| Epictetus | *Discourses* (selection) and *Encheiridion* | George Long | [Project Gutenberg #10661](https://www.gutenberg.org/ebooks/10661) |
| Seneca | *Moral Letters to Lucilius* | Richard Mott Gummere (1917–1925) | [Wikisource](https://en.wikisource.org/wiki/Moral_letters_to_Lucilius) |

Two Seneca lines are sayings he quotes from other Stoics and are credited to
them: Hecato (Letter 9) and Cleanthes (Letter 107).

Wikisource letters were checked at these page revisions:

| Letter | Revision |
|---|---|
| 1 | [14843822](https://en.wikisource.org/w/index.php?oldid=14843822) |
| 2 | [14843823](https://en.wikisource.org/w/index.php?oldid=14843823) |
| 7 | [14843832](https://en.wikisource.org/w/index.php?oldid=14843832) |
| 9 | [14843835](https://en.wikisource.org/w/index.php?oldid=14843835) |
| 13 | [14843841](https://en.wikisource.org/w/index.php?oldid=14843841) |
| 16 | [14843846](https://en.wikisource.org/w/index.php?oldid=14843846) |
| 23 | [14843856](https://en.wikisource.org/w/index.php?oldid=14843856) |
| 28 | [14843862](https://en.wikisource.org/w/index.php?oldid=14843862) |
| 71 | [14843928](https://en.wikisource.org/w/index.php?oldid=14843928) |
| 98 | [14843973](https://en.wikisource.org/w/index.php?oldid=14843973) |
| 101 | [14843979](https://en.wikisource.org/w/index.php?oldid=14843979) |
| 107 | [14843989](https://en.wikisource.org/w/index.php?oldid=14843989) |

## Verifying or adding quotes

Quotes live in `scripts/quotes.source.json`. To check them and regenerate
`Quotes.js` (maintainers only; needs Python 3 and network access):

```bash
scripts/verify-quotes.py --write
```

The script downloads the editions above, confirms each quote appears verbatim
(ignoring only whitespace, curly vs straight quotes, translator's brackets,
letter case, and a trailing punctuation mark), adds the book or letter
citation, and refuses to write `Quotes.js` if any quote is not found.
