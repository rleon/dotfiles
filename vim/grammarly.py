from __future__ import print_function

import vim

def filter_buffer(buf, ft):
    delete_lines = ("Issue: ", "Change-Id: ",
            "Signed-off-by: ", "Reviewed-off-by: ",
            "Acked-by: ", "From: ", "To: ", "Cc: ",
            "Date: ")
    end_merker = ("Thanks", "# Please enter the comm", "---")

    first_line = True
    text = str()

    for line in buf:
        if ft == "gitsendemail" and first_line:
            # First line has git info which we prefer to remove
            # From 9eaba99f63d4d8f1ecdf8039914bc37273d6618c Mon Sep 17 00:00:00 2001
            first_line = False
            continue

        if line.startswith(delete_lines):
            continue

        if line.startswith(end_merker):
            break

        if ft == "gitsendemail" and line.startswith("Subject: "):
            line = ''.join(line.split('] ')[1:])

        text += line + '\n'
    return text

def main():
    ft = vim.eval("&ft")
    text = filter_buffer(vim.current.buffer, ft)

    with open('/tmp/vim-grammarly.txt', 'w') as f:
        f.write(text)

main()
