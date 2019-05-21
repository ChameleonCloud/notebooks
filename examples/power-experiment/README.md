# Power experiment

This example shows how you can remotely drive an experiment on a provisioned bare metal node. In this example, the Jupyter Notebook is used to upload the experimental scripts, remotely start the experiment, and then download the results and analyze using a separate analysis Notebook.

## Instructions

1. Start with the `RunExperiment` Notebook and initialize the variables (`FLOATING_IP`).
1. Run the `RunExperiment` Notebook. It should download results to a folder called `./out`.
1. Run the `Analysis` Notebook to process and graph the results.
