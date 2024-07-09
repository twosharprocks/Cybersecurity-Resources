import subprocess
import shlex

def convert_pdf_to_text(pdf_file):
    try:
        # Use shlex.split to handle file paths with spaces correctly
        cmd = shlex.split(f'pdftotext {shlex.quote(pdf_file)} -')
        # Convert PDF to text and capture the output
        result = subprocess.run(cmd, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        print(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Error converting {pdf_file} to text: {e.stderr}")

def main():
    pdf_file = input("Please enter the path to the PDF file: ").strip()
    
    # Convert PDF to text and print to terminal
    convert_pdf_to_text(pdf_file)

if __name__ == "__main__":
    main()
