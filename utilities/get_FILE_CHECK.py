import pandas as pd


def compare_FILE_CHECK(data_dict: dict) -> pd.DataFrame():

    df = data_dict["FILE_CHECK"]

    checklist_values = df['Checklist'].values
    description_values = df['Description'].values
    idx_values = df['Index'].values
    mask_values = df['Mask'].values
    actual_value_list = df['Actual Value'].values

    result_lists = []

    for idx, val in enumerate(checklist_values):

        pass_result = False
        mask = str(mask_values[idx])
        actual_value = actual_value_list[idx].lower()
        

        if "no such file or directory" in actual_value:
            pass_result = False
            file_mask = "No such file or directory"

        else:
            file_mask = ''
            for i in actual_value[1:4]:
                file_mask += str(7-int(i))

            if file_mask == mask:
                pass_result = True

        if pass_result:
            print(
                f"{idx_values[idx]}: PASSED | Expected mask: {mask} | Actual mask: {file_mask}")
            result_lists.append("PASSED")
        else:
            print(
                f"{idx_values[idx]}: FAILED | Expected mask: {mask} | Actual mask: {file_mask}")
            result_lists.append("FAILED")

    col_name1 = 'ip_addr' + ' | Actual Value'
    col_name2 = 'ip_addr' + ' | Result'

    df = df.rename(columns={'Actual Value': col_name1})
    df[col_name1] = actual_value_list
    df[col_name2] = result_lists

    return df
