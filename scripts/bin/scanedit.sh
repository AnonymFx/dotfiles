#!/bin/sh
if [ "$#" -lt 1 ]; then
	echo 'Provide files to edit'
	exit 1
fi

if ! gscan2pdf_location=$(type -p gscan2pdf) || [ ! -n "$gscan2pdf_location" ]; then
	echo 'Pls install gscan2pdf'
	exit 1
fi
if !  pdf2ps_location=$(type -p pdf2ps) || [ ! -n "$pdf2ps_location" ]; then
	echo 'Pls install ghostscript'
	exit 1
fi
if ! ps2pdf_location=$(type -p ps2pdf) || [ ! -n "$ps2pdf_location" ]; then
	echo 'Pls install ghostscript'
	exit 1
fi

for scan_file in $@; do
	filename=$(basename "$scan_file")
	extension="${filename##*.}"
	filename="${filename%.*}"
	path=$(dirname "$scan_file")
	file="$path/$filename"
	if [ ! "$extension" == "pdf" ]; then
		echo "$scan_file is not a pdf file"
		continue
	fi

	echo
	echo "Starting with $scan_file"

	# OCR prompt
	echo "Would you like to start OCR? [(Y)es/(n)o]:"
	read line
	if [[ "$line" == Y* ]] || [[ "$line" == y* ]] || [ -z "$line" ]; then
		echo "Starting gscan2pdf for OCR, open file '$PWD/$scan_file'"
		gscan2pdf > /dev/null 2>&1
	fi

	# File shrinking
	echo "Would you like to reduce the file size? [(Y)es/(n)o]:"
	read line
	if [[ "$line" == Y* ]] || [[ "$line" == y* ]] || [ -z "$line" ]; then
		echo "Starting file shrinking"
		echo "Converting to ps"
		pdf2ps "$scan_file" "$file.ps"
		echo "Success"
		echo "Converting back to pdf"
		ps2pdf "$file.ps" "$file.pdf"
		echo "Success"
		echo "Removing ps file"
		rm "$file.ps"
		echo "Success"
	fi
done
