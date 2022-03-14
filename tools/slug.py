#!/home/seb/dev/python/tkinter/venv/bin/python
from slugify import slugify
from fileinput import input

print(slugify(next(input())))

