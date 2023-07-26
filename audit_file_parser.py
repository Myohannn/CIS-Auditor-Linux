from bs4 import BeautifulSoup
import pandas as pd
import re
import argparse

# The regular expressions to extract required data
regexes = {
    'type': re.compile(r'type\s+:\s+(.*?)\n'),
    'description': re.compile(r'description\s+:\s+(.*?)\n'),
    'file': re.compile(r'file\s+:\s+(.*?)\n'),
    'owner': re.compile(r'owner\s+:\s+(.*?)\n'),
    'mask': re.compile(r'mask\s+:\s+(.*?)\n'),
    'required': re.compile(r'required\s+:\s+(.*?)\n'),
    'group': re.compile(r'group\s+:\s+(.*?)\n'),
    'cmd': re.compile(r'cmd\s+:\s+(.*?)\n'),
    'expect': re.compile(r'expect\s+:\s+(.*?)\n'),
    'regex': re.compile(r'regex\s+:\s+(.*?)\n'),
    'content': re.compile(r'content\s+:\s+(.*?)\n'),
    'is_substring': re.compile(r'is_substring\s+:\s+(.*?)\n')
}


# The dictionary maps different audit categories
data_dict = {
    "FILE_CHECK_NOT": [],
    "CMD_EXEC": [],
    "FILE_CONTENT_CHECK_NOT": [],
    "FILE_CHECK": [],
    "BANNER_CHECK": [],
    "FILE_CONTENT_CHECK": []
}


def read_file(filename: str) -> str:
    '''This function will read the content of the provided file
    '''

    contents = ''
    try:
        with open(filename, 'r') as file_in:
            contents = file_in.read()
    except Exception as e:
        print('ERROR: reading file: {}: {}'.format(filename, e))

    return contents


def save_file(out_fname):
    '''This function will save the result into the given path (out_fname)
    '''

    writer = pd.ExcelWriter(out_fname, engine='openpyxl')

    for type, data in data_dict.items():
        df = pd.DataFrame(data, columns=['Checklist', 'Type', 'Index', 'Description',
                                         'File',  'Owner', 'Mask', 'Required', 'Group', 'CMD', 'Expect', 'Regex', 'Content', 'Is_substring'])
        df.to_excel(writer, sheet_name=type, index=False)

    writer.close()


def find_element(audit_policies: str) -> None:
    '''This function will find the required elements based on the regular expression (regexes),
    and the content (audit). Finally, it will save the results into a dictionary (data_dict)
    '''

    soup = BeautifulSoup(audit_policies, 'lxml')

    # Find all the custom_item elements
    items = soup.find_all('custom_item')

    # Extract the required data from each custom_item
    for item in items:
        item_str = str(item)
        # item_str = str(item).replace('"', '')

        type = regexes['type'].search(item_str)
        type = type.group(1) if type else None

        description = regexes['description'].search(item_str)
        description = description.group(1) if description else None
        description = description.strip('"')

        if description[0].isdigit():
            index = re.search(r'(.*?)\s', description)
            index = index.group(1) if index else None
            description = description.replace(index, '').strip()
        else:
            index = 0

        file_var = regexes['file'].search(item_str)
        file_var = (file_var.group(1)).strip('"') if file_var else None

        owner_var = regexes['owner'].search(item_str)
        owner_var = (owner_var.group(1)).strip('"') if owner_var else None

        mask_var = regexes['mask'].search(item_str)
        mask_var = (mask_var.group(1)).strip('"') if mask_var else None

        required_var = regexes['required'].search(item_str)
        required_var = (required_var.group(1)).strip(
            '"') if required_var else None

        group_var = regexes['group'].search(item_str)
        group_var = (group_var.group(1)).strip('"') if group_var else None

        cmd_var = regexes['cmd'].search(item_str)
        cmd_var = (cmd_var.group(1)).strip('"') if cmd_var else None

        expect_var = regexes['expect'].search(item_str)
        expect_var = (expect_var.group(1)).strip('"') if expect_var else None

        regex_var = regexes['regex'].search(item_str)
        regex_var = (regex_var.group(1)).strip('"') if regex_var else None

        content_var = regexes['content'].search(item_str)
        content_var = (content_var.group(1)).strip(
            '"') if content_var else None

        is_substring_var = regexes['is_substring'].search(item_str)
        is_substring_var = (is_substring_var.group(1)).strip(
            '"') if is_substring_var else None

        # Clean the data
        if cmd_var:
            cmd_var = cmd_var.replace('\\"', '"').replace("\\'", "'").replace('\\\\n', '\\n').replace("\\\\", "\\").replace("&gt;",">").replace("&amp;","&")

        data_dict[type].append([1, type, index, description,
                                file_var, owner_var, mask_var, required_var, group_var, cmd_var, expect_var, regex_var, content_var, is_substring_var])


if __name__ == '__main__':

    # my_parser = argparse.ArgumentParser(
    #     description='A Customizable Multiprocessing Remote Security Audit Program')

    # # Add the arguments
    # my_parser.add_argument('--audit',
    #                        type=str,
    #                        required=True,
    #                        help='The path of audit file')

    # # Execute parse_args()
    # args = my_parser.parse_args()

    # print('Aduit file:', args.audit)

    src_fname = 'src\CIS\CIS_Debian_Linux_10_v1.0.0_L1_Server.audit'
    # src_fname = args.audit

    # read .audit file
    audit_policies = read_file(src_fname)

    # extract the required audit data
    data = find_element(audit_policies)

    # save the data into an Excel file
    # out_fname = 'src\win_server_2022_ms_v1.xlsx'
    out_fname = 'src\\Audit\\' + \
        src_fname.split("\\")[-1].replace("audit", "xlsx")

    save_file(out_fname)

    print(f"File export success --- {out_fname}")
