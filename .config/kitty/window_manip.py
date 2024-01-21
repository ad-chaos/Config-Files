import sys
from kitty.boss import Boss
from kitty.options.types import Options
from kitty.fast_data_types import os_window_focus_counters, set_os_window_pos
from kittens.tui.handler import result_handler


def main(args: list[str]):
    pass


def goto_parent(boss: Boss):
    fc_map = os_window_focus_counters()
    s = sorted(fc_map.keys(), key=fc_map.__getitem__)
    if not s or len(s) < 2:
        return
    os_window_id = s[-2]

    boss._move_tab_to(target_os_window_id=os_window_id)


def small_float(boss: Boss):
    osw_id = boss.add_os_window()
    boss.resize_os_window(osw_id, 50, 20, 'cells')
    set_os_window_pos(osw_id, 865, 240)

    boss.os_window_map[osw_id].new_tab(empty_tab=True, location="default").new_window()


@result_handler(no_ui=True)
def handle_result(args: list[str], answer: str, target_window_id: int, boss: Boss):
    match args[1]:
        case "small-term":
            small_float(boss)
        case "retach":
            goto_parent(boss)
