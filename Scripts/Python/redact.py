import re
import chardet

def read_file(file_path):
    with open(file_path, 'rb') as file:
        raw_data = file.read()
        result = chardet.detect(raw_data)
        encoding = result['encoding']
    with open(file_path, 'r', encoding=encoding) as file:
        return file.read()

def write_file(file_path, content):
    with open(file_path, 'w', encoding='utf-8') as file:
        file.write(content)

def redact_company_name(text, company_name):
    return re.sub(re.escape(company_name), '[REDACTED]', text, flags=re.IGNORECASE)

def main():
    # Prompt the user to enter the file paths and company name
    input_file = input("Please enter the path to the input file: ")
    output_file = input("Please enter the name for the output file: ")
    company_name = input("Please enter the company name to redact: ")

    try:
        # Read the original file
        original_text = read_file(input_file)
    except UnicodeDecodeError as e:
        print(f"Error reading file: {e}")
        return

    # Redact the company name
    redacted_text = redact_company_name(original_text, company_name)

    # Write the redacted text to the output file
    write_file(output_file, redacted_text)

if __name__ == "__main__":
    main()