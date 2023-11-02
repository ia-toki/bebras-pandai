import json
import os
from firebase_admin import credentials, initialize_app, firestore
from glob import glob

creds = credentials.Certificate(
    json.loads(os.environ["FIREBASE_SECRET_KEY_JSON"])
)
initialize_app(creds)
firestore_client = firestore.client()


def update_info(file_list):
    col_ref = firestore_client.collection("learning_material")
    for file in file_list:
        with open(file, "r") as f:
            file_ref = file.replace(".json", "").split("/")
            name = file_ref[-1]
            content = json.load(f)
            col_ref.document(name).set(content)


if __name__ == "__main__":
    updated_files = os.getenv("FILES_ADDED_AND_MODIFIED_ON_GIT")
    if updated_files is not None:
        # filter which start with `data/learning_material/` only
        file_list = [path for path in updated_files.split("\n") if path.startswith("data/learning_material/")]
    else:
        file_list = glob("data/learning_material/*/*.json")
    
    update_info(file_list)
