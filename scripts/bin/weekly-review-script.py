#!/Users/marlon/.pyenv/shims/python3

import os
from collections.abc import Callable
from datetime import date, timedelta
from pathlib import Path

# functions


def main():

    def get_past_week_dates():
        today = date.today()
        dates = [
            (today - timedelta(days=i)).strftime("%Y-%m-%d") for i in range(7)
        ]
        return dates

    def get_template(template_file) -> Path:
        return Path(f"{second_brain_path}/_templates/{template_file}")

    def get_template_content(
        fetch_template: Callable, template_path: str
    ) -> str:
        template = fetch_template(template_path)
        return open(template, "r").read()

    def create_wiki_link(filename: str) -> str:
        return f"[[{filename}]]"

    today = date.today().strftime("%Y-%m-%d")

    # Paths
    second_brain_path = Path(
        "/Users/marlon/Library/Mobile Documents/iCloud~md~obsidian/Documents/secondbrain"
    )
    reflection_and_journaling_path = Path(
        f"{second_brain_path}/NewBrain/ReflectionAndJournaling"
    )
    weekly_review_path = Path(
        f"{reflection_and_journaling_path}/WeeklyReviews"
    )

    # get weekly review template
    template_content = get_template_content(
        get_template, "weekly-review-template.md"
    )

    wiki_dates_list = list(map(create_wiki_link, get_past_week_dates()))

    template_content = template_content.replace(
        "date-placeholder", today
    ).replace("Weekly Review Template", f"Weekly Review : {today}")

    for wiki in wiki_dates_list:
        template_content += f"\n- {wiki}"

    weekly_review_file = Path(f"{weekly_review_path}/Weekly_Review_{today}.md")
    with open(weekly_review_file, "w") as file:
        file.write(template_content)
    print(template_content)


main()
