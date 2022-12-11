def filter_paste(text: str) -> str:
    # Only going to have it for links that look like https://github.com/{user_or_org}/{project_name}
    github_link = text.find("github.com")
    project = text[github_link:].split("/")
    if github_link > 0:
        print(len(project), project[-1])
        match (len(project), project[-1]):
            case (3, _):
                return f"git clone {text} && cd {project[-1]}"
            case (4, "r"):
                return f"git remote add temp_tt {text}; git remote rename temp_tt "
            case (4, "i"):
                return text[:-1]
    return text
