#1/bin/python
#APP.PY    Flask server to serve html or plain text depending on client's useragent string
#Requires flask, pygments, markdown

import sys
import os
import markdown
import markdown.extensions.fenced_code
import markdown.extensions.codehilite
from flask import Flask, request, make_response, render_template, abort
from pygments.formatters import HtmlFormatter

PLAIN_TEXT_AGENTS = [ "curl", "httpie", "lwp-request", "wget", "python-requests", "openbsd ftp", "powershell", "fetch" ]

app = Flask(__name__)

def to_html(lines):
    md = markdown.markdown(lines, extensions=["fenced_code", "codehilite"])
    formatter = HtmlFormatter(style="monokai",full=True,cssclass="codehilite")
    css_string = formatter.get_style_defs() + "\nbody { background-color: #33363B; color: #CCCCCC;}\ntd.linenos pre { background-color: #AAAAAA; }"
    return "<style>" + css_string + "</style>" + md


def get_filepath(path, is_man):
    if is_man:
        if path == None:
            return "./man/README.md"
        elif os.path.isfile("./man/" + path):
            return "./man/" + path
        elif os.path.isfile("./man/" + path + ".md"):
            return "./man/" + path + ".md"
    else:
        if path == None:
            return "./README.md"
        elif os.path.isfile("./" + path):
            return "./" + path
        elif os.path.isfile("./" + path + ".sh"):
            return "./" + path + ".sh"
    return None

def try_get_lines(filepath):
    if filepath == None:
        return ""
    with open(filepath) as f:
        lines = f.read()
    return lines

@app.route("/")
@app.route("/<path>")
def get_file(path=None):
    filepath = get_filepath(path, False)
    user_agent = request.headers.get('User-Agent', '').lower()
    if any([x in user_agent for x in PLAIN_TEXT_AGENTS]):
        return "Error: file not found" if filepath == None else try_get_lines(filepath)
    else:
        filepath2 = get_filepath(path, True)
        if filepath == None and filepath2 == None:
            abort(404)
        lines = try_get_lines(filepath)
        if filepath == "./README.md":
            return to_html(lines)
        lines2 = try_get_lines(filepath2)
        return to_html(lines2 + "\n##CODE:\n```\n" + lines + "\n```")


@app.route("/man/<path>")
def get_man(path=None):
    filepath = get_filepath(path, True)
    user_agent = request.headers.get('User-Agent', '').lower()
    if any([x in user_agent for x in PLAIN_TEXT_AGENTS]):
        return "Error: file not found" if filepath == None else try_get_lines(filepath)
    else:
        if filepath == None:
            abort(404)
        lines = try_get_lines(filepath)
        return to_html(lines)


@app.route("/raw/<path>")
def get_raw(path=None):
    filepath = get_filepath(path, False)
    user_agent = request.headers.get('User-Agent', '').lower()
    if any([x in user_agent for x in PLAIN_TEXT_AGENTS]):
        return "Error: file not found" if filepath == None else try_get_lines(filepath)
    else:
        if filepath == None:
            abort(404)
        resp = make_response(try_get_lines(filepath))
        resp.mimetype = 'text/plain'
        return resp


@app.route("/raw/man/<path>")
def get_raw(path=None):
    filepath = get_filepath(path, True)
    user_agent = request.headers.get('User-Agent', '').lower()
    if any([x in user_agent for x in PLAIN_TEXT_AGENTS]):
        return "Error: file not found" if filepath == None else try_get_lines(filepath)
    else:
        if filepath == None:
            abort(404)
        resp = make_response(try_get_lines(filepath))
        resp.mimetype = 'text/plain'
        return resp


if __name__ == '__main__':
    app.run()
