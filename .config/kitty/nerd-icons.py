from collections.abc import Iterator
from itertools import starmap, groupby
from more_itertools import first, last, consecutive_groups
from functools import partial
import requests

fst = lambda f, _: f
snd = lambda _, s: s
sub = lambda val: val[1] - val[0]
hexint = partial(int, base=16)
codepoint = lambda code: hex(code)[2:].upper()


def json_to_int_ranges(json_data) -> Iterator[tuple[int, int | None]]:
    return map(
        lambda group: (first(group), last(group, None)),
        consecutive_groups(
            starmap(
                fst,
                groupby(
                    sorted(
                        map(
                            hexint,
                            starmap(
                                snd,
                                map(dict.values, json_data.values()),
                            ),
                        )
                    ),
                ),
            )
        ),
    )


glyph_names = requests.get(
    "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/glyphnames.json"
).json()
version = glyph_names["METADATA"]["version"]
del glyph_names["METADATA"]

with open("nerd-icons.conf", "w") as f:
    f.write(f"# Generated for Nerd font version: {version}\n")
    f.write(f"symbol_map ")
    f.write(
        ",".join(
            starmap(
                lambda start, stop: f"U+{codepoint(start)}{f'-U+{codepoint(stop)}' if stop else ''}",
                json_to_int_ranges(glyph_names),
            )
        )
    )
    f.write(" Symbols Nerd Font Mono\n")
