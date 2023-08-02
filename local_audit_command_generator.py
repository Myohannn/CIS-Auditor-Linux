import pandas as pd
import argparse


def gen_bash_cmd(data_dict: dict) -> dict:

    bash_cmd_dict = {}

    for key, df in data_dict.items():

        checklist_value_list = df['Checklist'].values
        description_value_list = df['Description'].values
        CMD_value_list = df['CMD'].values
        File_value_list = df['File'].values

        if key == "CMD_EXEC":
            CMD_EXEC_cmds = []

            for idx, val in enumerate(checklist_value_list):
                cmd = CMD_value_list[idx]

                # CMD_EXEC_cmds.append(f"\necho '=={idx}==' \n"+cmd)
                CMD_EXEC_cmds.append(f"\necho '==|==' \n"+cmd)

            bash_cmd_dict[key] = ''.join(CMD_EXEC_cmds)

        if key == "FILE_CHECK_NOT":
            FILE_CHECK_NOT_cmds = []

            for idx, val in enumerate(checklist_value_list):
                file_path = File_value_list[idx]

                FILE_CHECK_NOT_cmds.append(
                    "\necho '==|==' \nstat " + file_path)

            bash_cmd_dict[key] = ''.join(FILE_CHECK_NOT_cmds)
        
        if key == "FILE_CHECK":
            FILE_CHECK_cmds = []

            for idx, val in enumerate(checklist_value_list):
                file_path = File_value_list[idx]

                FILE_CHECK_cmds.append(
                    "\necho '==|==' \nstat -c %a " + file_path)

            bash_cmd_dict[key] = ''.join(FILE_CHECK_cmds)

    return bash_cmd_dict


def read_file(fname: str) -> dict:
    '''The function will read the audit file and return a dictionary based on the audit type
    '''
    data_dict = {
        "FILE_CHECK_NOT": [],
        "CMD_EXEC": [],
        "FILE_CONTENT_CHECK_NOT": [],
        "FILE_CHECK": [],
        "BANNER_CHECK": [],
        "FILE_CONTENT_CHECK": []
    }

    xl = pd.ExcelFile(fname)
    # df = xl.parse(sheet_name=0)

    for type in data_dict:
        try:
            data_dict[type] = xl.parse(sheet_name=type)
        except ValueError as e:
            print(e)

    return data_dict


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

    # # fname = "src\Audit\CIS_MS_Windows_11_Enterprise_Level_1_v1.0.0.xlsx"
    # fname = args.audit

    # read audit file
    fname = "src\Audit\CIS_Debian_Linux_10_v1.0.0_L1_Server.xlsx"
    data_dict = read_file(fname)
    bash_cmd_dict = gen_bash_cmd(data_dict)

    # save file
    script_name = 'out\\script\\' + \
        fname.split("\\")[-1].replace("xlsx", "sh")

    with open(script_name, 'w') as f:
        f.write("#!/bin/bash\n")
        for key in bash_cmd_dict:
            for cmd in bash_cmd_dict[key]:
                f.write(cmd)
            f.write(";")

    print("Done! File saved: %s", script_name)
