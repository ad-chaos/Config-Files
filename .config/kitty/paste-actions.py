def filter_paste(text: str) -> str:
    """Fancy Git cloner
    Filters links that look like https://github.com/{user_or_org}/{project_name}/{modifiers}
    when modifier is `i` it means it should ignore the link for modification
    else it'll be considered the remote name
    """

    if (github_link := text.find("github.com")) == -1:
        return text

    link, _, modifier = text.rpartition("/")
    parts = text[github_link:].count("/") + 1
    match (parts, modifier):
        case (3, project_name):
            return f"git clone {text} && cd {project_name}"
        case (4, "i"):
            return text[:-1]
        case (4, remote_name):
            return f"git remote add {remote_name} {link}"

    assert False, "unreachable"

# Tests
if __name__ == "__main__":
    print(filter_paste("https://github.com/org/user"))
    print(filter_paste("https://github.com/org/user/i"))
    print(filter_paste("https://github.com/org/user/a_remote"))
