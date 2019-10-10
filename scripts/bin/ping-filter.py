#!/usr/bin/python

import sys
import argparse
import datetime
import re


def main(argv):
    min_ping = -1
    output = sys.stdout

    # parse arguments
    argparser = argparse.ArgumentParser();
    argparser.add_argument("input")
    argparser.add_argument("-o", "--output")
    argparser.add_argument("-t", "--min_ping")
    args = argparser.parse_args()

    # assign arguments
    input = open(args.input)
    if args.output:
        output = open(args.output)
    if args.min_ping:
        try:
            min_ping = float(args.min_ping)
        except ValueError:
            print("min_ping needs to be a number")
            return

    for line in input:
        timestamp = parse_time(line)
        ip = parse_ip(line)
        ping = parse_ping(line)

        # skip lines without ping
        if ping == -1:
            continue

        if ping >= min_ping:
            print("[%(timestamp)s] Ping to %(ip)s in %(ping)s ms" % {"timestamp": timestamp, "ip": ip, "ping": ping})


def parse_time(line):
    pattern = "\[\d+.\d+\]"
    occurrences = re.findall(pattern, line)
    if len(occurrences) > 0:
        time_ms = float(occurrences[0][1:-1])
        return datetime.datetime.fromtimestamp(time_ms).strftime("%Y-%m-%D %H:%M:%S")
    return ""


def parse_ping(line):
    pattern = "time=\d+.\d+ ms"
    occurrences = re.findall(pattern, line)
    if len(occurrences) > 0:
        return float(occurrences[0][5:-3])
    return -1


def parse_ip(line):
    pattern = "\(.*\)"
    occurrences = re.findall(pattern, line)
    if len(occurrences) > 0:
        return occurrences[0][1:-1]
    return ""


if __name__ == "__main__":
    main(sys.argv[1:])
