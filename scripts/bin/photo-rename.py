#!/usr/bin/env python3
import os
import argparse
import time
from PIL import Image


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
            files.sort(key=lambda file: get_image_created_date(Image.open(file)))
        except KeyError:
            print("Sorting not possible, one or more files don't have a creation date.\n"
                  "Please try again without the sorting option.")
            return
    else:
        files.sort(key=lambda file: file)

    index = 1 if(not args.index) else args.index
    decimal_count = len(str(len(files))) if(not args.decimal) else args.decimal
    for file in files:
        index_string = "{index:0{width}d}".format(width=decimal_count, index=index)
        name, file_extension = os.path.splitext(file)
        filepath = os.path.dirname(file)
        new_file = index_string + " " + filename + file_extension
        new_file_path = os.path.join(filepath, new_file)
        os.rename(file, new_file_path)
        index += 1


def get_image_created_date(image):
    date_created_text = image._getexif()[36867]
    date_created = time.strptime(date_created_text, "%Y:%m:%d %H:%M:%S")
    return date_created


if __name__ == "__main__":
    main()
