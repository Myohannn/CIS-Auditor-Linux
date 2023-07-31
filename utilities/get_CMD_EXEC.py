
def compare_CMD_EXEC(data_dict: dict) -> dict:
    # reg check
    df = data_dict["WMI_POLICY"]
    checklist_values = df['Checklist'].values
    idx_values = df['Index'].values
    value_data_values = df['Value Data'].values
    actual_value_list = df['Actual Value'].values

    result_lists = []

    for idx, val in enumerate(checklist_values):

        pass_result = True

        # if val == 1

        actual_value = actual_value_list[idx].lower().strip()
        expected_value = str(value_data_values[idx]).lower()
        expected_value = expected_value.split(" || ")

        if str(actual_value) in expected_value:
            pass_result = True
        else:
            pass_result = False

        if pass_result:
            print(
                f"{idx_values[idx]}: PASSED | Expected: {expected_value} | Actual: {actual_value}")
            result_lists.append("PASSED")
        else:
            print(
                f"{idx_values[idx]}: FAILED | Expected: {expected_value} | Actual: {actual_value}")
            result_lists.append("FAILED")

        # else:
        #     actual_value_list.append("")
        #     result_lists.append("")

    col_name1 = 'ip_addr' + ' | Actual Value'
    col_name2 = 'ip_addr' + ' | Result'

    df = df.rename(columns={'Actual Value': col_name1})
    df[col_name1] = actual_value_list
    df[col_name2] = result_lists

    return df
