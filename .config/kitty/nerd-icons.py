# ruff: noqa: E731

from collections.abc import Iterator
from itertools import starmap, groupby
from more_itertools import first, last, consecutive_groups
from functools import partial
import requests
import sys

fst = lambda f, _: f
snd = lambda _, s: s
sub = lambda val: val[1] - val[0]
hexint = partial(int, base=16)
codepoint = lambda code: hex(code)[2:].upper()

GlyphData = dict[str, dict[str, str]]
IntRange = tuple[int, int | None]


def json_to_int(json_data: GlyphData) -> Iterator[int]:
    return map(
        hexint,
        starmap(
            snd,
            map(dict.values, json_data.values()),
        ),
    )


def json_to_int_ranges(
    json_data: GlyphData,
) -> Iterator[IntRange]:
    return map(
        lambda group: (first(group), last(group, None)),
        consecutive_groups(
            starmap(
                fst,
                groupby(
                    sorted(json_to_int(json_data)),
                ),
            )
        ),
    )


def generate_file(json_data: GlyphData, version: str):
    with open("nerd-icons.conf", "w") as f:
        f.write(f"# Generated for Nerd font version: {version}\n")
        f.write("symbol_map ")
        f.write(
            ",".join(
                starmap(
                    lambda start,
                    stop: f"U+{codepoint(start)}{f'-U+{codepoint(stop)}' if stop else ''}",
                    json_to_int_ranges(json_data),
                )
            )
        )
        f.write(" Symbols Nerd Font Mono\n")


def print_all(json_data: GlyphData):
    print(*map(chr, json_to_int(glyph_names)))


glyph_names = requests.get(
    "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/glyphnames.json"
).json()
version = glyph_names["METADATA"]["version"]
del glyph_names["METADATA"]

if len(sys.argv) > 1:
    print_all(glyph_names)
else:
    generate_file(glyph_names, version)
