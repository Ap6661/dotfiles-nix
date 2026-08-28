from kittens.tui.handler import result_handler


def main(args: list[str]) -> str:
    return ""


@result_handler(no_ui=True)
def handle_result(args, answer, target_window_id, boss) -> None:
    import kitty.fast_data_types as f

    os_window_id = f.current_focused_os_window_id()
    current = f.background_opacity_of(os_window_id) or 1.0
    next_opacity = 1.0 if abs(current - 0.8) < 0.001 else 0.8

    boss.call_remote_control(
        None,
        ("set-background-opacity", str(next_opacity)),
    )
