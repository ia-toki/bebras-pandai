import json
import os
from firebase_admin import credentials, initialize_app, firestore
from glob import glob

creds = credentials.Certificate(
    json.loads(os.environ["FIREBASE_SECRET_KEY_JSON"])
)
initialize_app(creds)

firestore_client = firestore.client()
configuration_coll_ref = firestore_client.collection("configuration")
taskset_coll_ref = firestore_client.collection("task_set")

task_set_doc_index = []
file_list = glob("data/bebras_task/*/*/*.json")
for file in file_list:
    with open(file, "r") as f:
        file_ref = file.replace(".json", "").split("/")

        content = json.load(f)
        content["challenge_group"] = file_ref[-3]

        name = "{}_{}".format(file_ref[-3], file_ref[-1])
        taskset_coll_ref.document(name).set(content)
        task_set_doc_index.append({
            "doc_id": name,
            "title": content["title"],
            "challenge_group": content["challenge_group"],
        })

configuration_coll_ref.document('global_variables').update({
    "task_set_doc_index": task_set_doc_index
})