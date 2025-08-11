import os

# Define the list of states
state_lists = ['Texas', 'California', 'Florida', 'Washington']

for i in state_lists:
    output_file = f"{i}_covid_report.html"  # Customize the output file name
    command = (
        f'quarto render covid_10_quarto_python-share_reports.qmd '
        f'-P state_name:"{i}" '
        f'--output "{output_file}"'
    )
    os.system(command)
