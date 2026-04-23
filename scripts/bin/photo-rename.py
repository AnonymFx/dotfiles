#!/usr/bin/env python3
import os
import argparse
import time
from PIL import Image

DATE_TIME_ORIGINAL = 36867


def main():
    argparser = argparse.ArgumentParser()
    argparser.add_argument("-s", "--sorted", action='store_true')
    argparser.add_argument("-i", "--index", type=int)
    argparser.add_argument("-d", "--decimal", type=int)
    argparser.add_argument("name")
    argparser.add_argument("files", nargs="+")
    args = argparser.parse_args()

    filename = args.name
    files = args.files
    if args.sorted:
        try:
            files.sort(key=get_image_created_date)
        except ValueError as exc:
            print(f"Sorting not possible: {exc}\n"
                  "Please try again without the sorting option.")
            return
    else:
        files.sort()

    index = args.index if args.index is not None else 1
    decimal_count = args.decimal if args.decimal is not None else len(str(len(files)))
    for file in files:
        index_string = f"{index:0{decimal_count}d}"
        _, file_extension = os.path.splitext(file)
        filepath = os.path.dirname(file)
        new_file = index_string + " " + filename + file_extension
        new_file_path = os.path.join(filepath, new_file)
        if os.path.exists(new_file_path):
            print(f"Skipping {file}: target {new_file_path} already exists")
            continue
        os.rename(file, new_file_path)
        index += 1


def get_image_created_date(file):
    with Image.open(file) as image:
        date_created_text = image.getexif().get(DATE_TIME_ORIGINAL)
    if date_created_text is None:
        raise ValueError(f"{file} has no DateTimeOriginal EXIF tag")
    return time.strptime(date_created_text, "%Y:%m:%d %H:%M:%S")


if __name__ == "__main__":
    main()
