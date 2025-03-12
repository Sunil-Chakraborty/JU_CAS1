from xhtml2pdf import pisa             # import python module
from sanskrit_data.schema import common
import re

# Define your data
source_html = "<html><body><p>was going on.बाल्ये त्वं बहु रोदिषि स्म।</p></body></html>"
output_filename = "test.pdf"
source_html = "नमो भगवते वासुदेवाय"
tokens = re.findall(r'\w+', source_html)

token_string = ' '.join(tokens)

# Utility function
def convert_html_to_pdf(token_string, output_filename):
    # open output file for writing (truncated binary)
    result_file = open(output_filename, "w+b")

    # convert HTML to PDF
    pisa_status = pisa.CreatePDF(
            source_html,                # the HTML to convert
            dest=result_file)           # file handle to recieve result

    # close output file
    result_file.close()                 # close output file

    # return False on success and True on errors
    return pisa_status.err

# Main program
if __name__ == "__main__":
    pisa.showLogging()
    convert_html_to_pdf(source_html, output_filename)