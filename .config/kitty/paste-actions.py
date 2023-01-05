def filter_paste(text: str) -> str:
    """Fancy Git cloner
    Filters links that look like https://github.com/{user_or_org}/{project_name}/{modifiers}
    when modifier is `i` it means it should ignore the link for modification
    else it'll be considered the remote name
    """

    github_link = text.find("github.com")
    link, _, modifier = text.rpartition("/")
    parts = text[github_link:].count("/") + 1
    match (parts, modifier):
        case (3, project_name):
            return f"git clone {text} && cd {project_name}"
        case (4, "i"):
            return text[:-1]
        case (4, remote_name):
            return f"git remote add {remote_name} {link}"
        case _:
            return text

# Tests
if __name__ == "__main__":
    print(filter_paste("https://github.com/org/user"))
    print(filter_paste("https://github.com/org/user/i"))
    print(filter_paste("https://github.com/org/user/a_remote"))
    print(filter_paste("https://github.com/org/user/commit/aab81c2d32895950d46a62d34cba86c6eac11a15"))
    print(filter_paste("https://www.notawebsite.com/"))
    print(filter_paste("/////////"))
    print(filter_paste("github.com"))
