#!/usr/bin/python
import argparse
import os
import re


def main():
    # def arguments
    argparser = argparse.ArgumentParser()
    argparser.add_argument("input")
    argparser.add_argument("target")
    args = argparser.parse_args()

    # get input file
    if not os.path.isfile(args.input):
        raise Exception('File not found: ' + args.input)
    input_file = open(args.input)

    if os.path.isfile(args.target):
        os.remove(args.target)
    if not os.path.exists(os.path.dirname(args.target)):
        os.makedirs(os.path.dirname(args.target))
    output_file = open(args.target, 'w+')

    input_string = read_input(input_file)
    input_file.close()

    mappings = parse_input(input_string)

    write_output(mappings, output_file)
    output_file.close()


def read_input(file):
    # read file to string
    file_content = file.read()
    file_content = re.sub("(/\\*([^*]|[\\r\\n]|(\\*+([^*/]|[\\r\\n])))*\\*+/)|(//.*)", "", file_content)
    return file_content


def parse_input(input):
    def_strings = re.findall("\"[^\"]*\"\\s*=\\s*\"[^\"]*\";", input)
    mappings = []
    for string_def in def_strings:
        # remove semicolon
        string_def = string_def[:-1]

        # split at equals
        split = string_def.split('=')
        if len(split) != 2:
            raise Exception('Invalid format in the input file at: ' + input)
        key = split[0].strip()
        value = split[1].strip()

        # remove quotes
        key = key[1:-1]
        value = value[1:-1]

        if "%@" in value:
            value = value.replace('%@', '%s')

        # handle html values
        if len(value) > 0 and value.strip()[0] == '<':
            value = '<![CDATA[' + value + ']]>'

        # add to list
        mappings.append((key, value))
    return mappings


def write_output(mappings, output_file):
    # write opening resources
    output_file.write('<resources\n'
                      '\txmlns:tools="http://schemas.android.com/tools"\n'
                      '\ttools:ignore="MissingTranslation">\n')

    # write key value pairs
    i = 1
    for (key, value) in mappings:
        key_value_string = '\t<string name=\"{0}\">{1}</string>\n'
        if "%" in value:
            key_value_string = '\t<string formatted=\"false\" name=\"{0}\">{1}</string>\n'

        key_value_string = key_value_string.format(key, value)
        output_file.write(key_value_string)

    # write closing resources
    output_file.write('</resources>')
    pass


if __name__ == "__main__":
    main()
