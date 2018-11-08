# Getting small scanned documents in gscan2pdf and pngquant
1. Install both tools
2. In gscan2pdf, add a user-defined tool under `File -> Preferences -> Gerneral options (tab at the top of the dialog) -> Add (bottom of the dialog)` with the following command: `pngquant 4 %i -f --ext .png`. The number in the command can be in-/decreased for more/less colors and higher/lower file size.
3. Restart gscan2pdf
4. When scanning a new page, check the options for `Process with user-defined tool` and optionally `OCR scanned pages` or do these steps after having scanned the image. You can find them under the Tools menu option.  
Hint: I'd recommend a DPI of >=300dpi for OCR to work adequately
5. When saving the document, check the downsample option (e.g. to 150dpi).

