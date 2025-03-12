import aspose.words as aw
from datetime import date

# Load PDF files
PDF1 = aw.Document("first.pdf")
PDF2 = aw.Document("second.pdf")

# Convert PDF files to Word format
PDF1.save("first.docx", aw.SaveFormat.DOCX)
PDF2.save("second.docx", aw.SaveFormat.DOCX)

# Load converted Word documents 
DOC1 = aw.Document("first.docx")
DOC2 = aw.Document("second.docx")

# Set comparison options
options = aw.comparing.CompareOptions()            
options.ignore_formatting = True
options.ignore_headers_and_footers = True
options.ignore_case_changes = True
options.ignore_tables = True
options.ignore_fields = True
options.ignore_comments = True
options.ignore_textboxes = True
options.ignore_footnotes = True

# DOC1 will contain changes as revisions after comparison
DOC1.compare(DOC2, "user", date.today(), options)

if (DOC1.revisions.count > 0):
    # Save resultant file as PDF
    DOC1.save("compared.pdf", aw.SaveFormat.PDF)
else:
    print("Documents are equal")
    