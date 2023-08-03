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
    'cmd': re.compile(r'cmd\s*:\s*(.+?)\n\s*expect', re.DOTALL | re.IGNORECASE),
    'expect': re.compile(r'expect\s+:\s+(.*?)\n'),
    'regex': re.compile(r'regex\s+:\s+(.*?)\n'),
    'content': re.compile(r'content\s+:\s+(.*?)\n'),
    'is_substring': re.compile(r'is_substring\s+:\s+(.*?)\n'),
    'solution': re.compile(r'solution\s*:\s*(.+?)\n\s*reference', re.DOTALL | re.IGNORECASE)
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

    for audit_type, data in data_dict.items():
        df = pd.DataFrame(data, columns=['Checklist', 'Type', 'Index', 'Description', 'Solution',
                                         'File',  'Owner', 'Mask', 'Required', 'Group', 'CMD', 'Expect', 'Regex', 'Content', 'Is_substring'])
        df.to_excel(writer, sheet_name=audit_type, index=False)

    writer.close()


def find_element(audit_policies: str) -> None:
    '''This function will find the required elements based on the regular expression (regexes),
    and the content (audit). Finally, it will save the results into a dictionary (data_dict)
    '''

    soup = BeautifulSoup(audit_policies, 'lxml')

    # Find all the custom_item elements
    items = soup.find_all('custom_item')

    type_set = set()

    # Extract the required data from each custom_item
    for item in items:
        item_str = str(item)
        # item_str = str(item).replace('"', '')

        audit_type = regexes['type'].search(item_str)
        audit_type = audit_type.group(1) if audit_type else None
        type_set.add(audit_type)

        solution = regexes['solution'].search(item_str)
        solution = solution.group(1)[1:-1].replace(
            '\n', ' ') if solution else None

        description = regexes['description'].search(item_str)
        description = description.group(1) if description else None
        description = description[1:-1]

        if description[0].isdigit():
            index = re.search(r'(.*?)\s', description)
            index = index.group(1) if index else None
            description = description.replace(index, '').strip()
        else:
            continue

        file_var = regexes['file'].search(item_str)
        file_var = (file_var.group(1))[1:-1] if file_var else None

        owner_var = regexes['owner'].search(item_str)
        owner_var = (owner_var.group(1))[1:-1] if owner_var else None

        mask_var = regexes['mask'].search(item_str)
        mask_var = (mask_var.group(1))[1:-1] if mask_var else None

        required_var = regexes['required'].search(item_str)
        required_var = (required_var.group(1))[1:-1] if required_var else None

        group_var = regexes['group'].search(item_str)
        group_var = (group_var.group(1))[1:-1] if group_var else None

        cmd_var = regexes['cmd'].search(item_str)
        cmd_var = (cmd_var.group(1))[1:-1] if cmd_var else None

        expect_var = regexes['expect'].search(item_str)
        expect_var = (expect_var.group(1))[1:-1] if expect_var else None

        regex_var = regexes['regex'].search(item_str)
        regex_var = (regex_var.group(1))[1:-1] if regex_var else None

        content_var = regexes['content'].search(item_str)
        content_var = (content_var.group(1))[1:-1] if content_var else None

        is_substring_var = regexes['is_substring'].search(item_str)
        is_substring_var = (is_substring_var.group(1))[
            1:-1] if is_substring_var else None

        # Clean the data
        if cmd_var:

            cmd_var = cmd_var.replace('\\"', '"').replace("\\'", "'").replace(
                '\\\\n', '\\n').replace("\\\\", "\\").replace("&gt;", ">").replace("&amp;", "&").replace("&lt;", "<")
            
            if "Ensure all current passwords uses the configured hashing algorithm" in description:
                cmd_var = "echo Manual"
            elif "Ensure ip6tables firewall rules exist for all open ports" in description:
                cmd_var = cmd_var.replace("exit", "echo")

        if expect_var:
            expect_var = expect_var.replace("\\\\", "\\")

        if regex_var:
            regex_var = regex_var.replace("\\\\", "\\").replace('\\\"', '\"')

        data_dict[audit_type].append([1, audit_type, index, description, solution,
                                      file_var, owner_var, str(mask_var), required_var, group_var, cmd_var, expect_var, regex_var, content_var, is_substring_var])


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

    src_fname = 'src\CIS\CIS_Debian_Linux_10_v2.0.0_L1_Server.audit'
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
