# -*- coding: utf-8 -*-
import io
from io import StringIO
from xhtml2pdf import pisa
from StringIO import StringIO

source = """<html>
            <style>
                @font-face {
                font-family: Preeti;
                src: url("preeti.ttf");
                }

                body {
                font-family: Preeti;
                }
            </style>
            <body>
                This is a test <br/>
                       सरल
            </body>
        </html>"""

# Utility function
def convertHtmlToPdf(source):
    # open output file for writing (truncated binary)

    pdf = StringIO()
    pisaStatus = pisa.CreatePDF(StringIO(source.encode('utf-8')), pdf)

    # return True on success and False on errors
    print ("Success: ", pisaStatus.err)
    return pdf

# Main program
if __name__=="__main__":
    #print pisa.showLogging()
    pdf = convertHtmlToPdf(source)
    fd = open("test.pdf", "w+b")
    fd.write(pdf.getvalue())
    fd.close()