import pandas as pd
import re


def compare_FILE_CONTENT_CHECK(data_dict: dict) -> pd.DataFrame():

    df = data_dict["FILE_CONTENT_CHECK"]

    checklist_values = df['Checklist'].values
    description_values = df['Description'].values
    idx_values = df['Index'].values
    required_values_list = df['Required'].values
    expect_values_list = df['Expect'].values
    actual_values_list = df['Actual Value'].values

    result_lists = []

    for idx, val in enumerate(checklist_values):

        pass_result = False
        expect_value = expect_values_list[idx].replace(
            "(?i)", "").replace("(?-i)", "")

        actual_value = actual_values_list[idx]
        if ':' in actual_value:
            actual_value = actual_value.split(":", 1)[1]
        required_value = required_values_list[idx]

        if actual_value == "" or actual_value == "\n":
            if required_value == "NO":
                pass_result = True
            actual_text = "Value not found"
        elif "No such file or directory" in actual_value:
            pass_result = True
            actual_text = "No such file or directory"
        else:
            pattern = re.compile(expect_value).search(actual_value)
            if pattern is None:
                if required_value == "NO":
                    pass_result = True
                actual_text = "Pattern not found"
            else:
                if required_value != "NO":
                    pass_result = True
                actual_text = (pattern.group(0)).strip('"')

        if pass_result:
            print(
                f"{idx_values[idx]}: PASSED | Expected value: {expect_value} | Actual value: {actual_text}")
            result_lists.append("PASSED")
        else:
            print(
                f"{idx_values[idx]}: FAILED | Expected value: {expect_value} | Actual value: {actual_text}")
            result_lists.append("FAILED")

    col_name1 = 'ip_addr' + ' | Actual Value'
    col_name2 = 'ip_addr' + ' | Result'

    df = df.rename(columns={'Actual Value': col_name1})
    df[col_name1] = actual_values_list
    df[col_name2] = result_lists

    return df
