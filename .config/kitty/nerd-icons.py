from itertools import pairwise, starmap, groupby, chain
from functools import partial
import requests

fst = lambda f, _: f
snd = lambda _, s: s
hexint = partial(int, base=16)
codepoint = lambda code: hex(code)[2:]
diff1 = lambda val: val[1] - val[0] < 2

glyph_names = requests.get(
    "https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/glyphnames.json"
).json()
del glyph_names["METADATA"]

codes = starmap(
    fst,
    groupby(
        sorted(
            map(
                hexint,
                starmap(
                    snd,
                    map(dict.values, glyph_names.values()),
                ),
            )
        ),
    ),
)

ranges = []
for is_range, group in groupby(pairwise(codes), diff1):
    if is_range:
        first, *_, last = chain.from_iterable(group)
        ranges.append(f"U+{codepoint(first)}-U+{codepoint(last)}")
    else:
        next(group)
        ranges.extend(f"U+{codepoint(fst(*t))}" for t in group)


with open("nerd-icons.conf", "w") as f:
    f.write(f"symbol_map {','.join(ranges)} Symbols Nerd Font Mono\n")
