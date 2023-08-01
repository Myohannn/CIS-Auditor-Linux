import re
import pandas as pd


def compare_CMD_EXEC(data_dict: dict) -> pd.DataFrame():

    df = data_dict["CMD_EXEC"]

    checklist_values = df['Checklist'].values
    description_values = df['Description'].values
    idx_values = df['Index'].values
    value_data_values = df['Expect'].values
    actual_value_list = df['Actual Value'].values

    result_lists = []

    for idx, val in enumerate(checklist_values):

        pass_result = True

        actual_value = actual_value_list[idx].lower().strip()
        expected_value = str(value_data_values[idx]).lower()

        pattern = re.compile(expected_value, re.MULTILINE).search(actual_value)

        if "chrony is configured - user" in description_values[idx] and actual_value is "":
            pass_result == True
        elif ("local-only mode - ss" in description_values[idx] or "outbound and established connections are configured" in description_values[idx]) and actual_value is "":
            pass_result == True
        elif ("firewall rules exist for all open ports" in description_values[idx] or "loopback traffic is configured - allow" in description_values[idx] or "loopback traffic is configured - deny" in description_values[idx] or "ufw" in description_values[idx] or "outbound connections are configured" in description_values[idx]) and "no such file or directory" in actual_value:
            pass_result == True
        elif ("rsyslog Service is enabled" in description_values[idx] or "logging is configured - '*.emerg :omusrmsg:*'" in description_values[idx] or "remote rsyslog messages are only accepted on designated log hosts" in description_values[idx] or "ufw" in description_values[idx] or " rsyslog default file permissions configured" in description_values[idx]) and "no such file or directory" in actual_value:
            pass_result == True
        elif ("Ensure default deny firewall policy" == description_values[idx]) and "no such file or directory" in actual_value:
            pass_result == True

        else:

            if pattern:
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

    col_name1 = 'ip_addr' + ' | Actual Value'
    col_name2 = 'ip_addr' + ' | Result'

    df = df.rename(columns={'Actual Value': col_name1})
    df[col_name1] = actual_value_list
    df[col_name2] = result_lists

    return df
