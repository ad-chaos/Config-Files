def filter_paste(text: str) -> str:
    """Fancy Git cloner
    Filters links that look like https://github.com/{user_or_org}/{project_name}/{modifiers}
    when modifier is `i` it means it should ignore the link for modification
    else it'll be considered the remote name
    """

    github_link = text.find("github.com")
    if github_link > 0:
        project = text[github_link:].split("/")
        match (len(project), project[-1]):
            case (3, _):
                return f"git clone {text} && cd {project[-1]}"
            case (4, "i"):
                return text[:-1]
            case (4, remote_name):
                return f"git remote add {remote_name} {text}"
    return text
