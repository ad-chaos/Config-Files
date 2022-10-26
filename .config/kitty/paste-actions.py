def filter_paste(text: str) -> str:
    # Only going to have it for links that look like https://github.com/{user_or_org}/{project_name}
    github_link = text.find("github.com")
    project = text[github_link:].split("/")
    if github_link>0 and len(project)==3:
        return f"git clone {text} && cd {project[-1]}"
    return text
