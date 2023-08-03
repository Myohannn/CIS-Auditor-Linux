import pandas as pd
import re


def compare_FILE_CONTENT_CHECK_NOT(data_dict: dict) -> pd.DataFrame():

    df = data_dict["FILE_CONTENT_CHECK_NOT"]

    checklist_values = df['Checklist'].values
    description_values = df['Description'].values
    idx_values = df['Index'].values
    expect_values_list = df['Expect'].values
    actual_value_list = df['Actual Value'].values

    result_lists = []

    for idx, val in enumerate(checklist_values):

        pass_result = False
        expect_value = expect_values_list[idx].replace('?-i','?i')
        actual_value = actual_value_list[idx]

        if actual_value == "":
            pass_result = True
            actual_text = "Value not found"
        else:
            pattern = re.compile(expect_value).search(actual_value)
            if pattern is None:
                pass_result = True
                actual_text = "Value not found"
            else:
                actual_text = (pattern.group(1)).strip('"')

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
    df[col_name1] = actual_value_list
    df[col_name2] = result_lists

    return df
