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

task_set_doc_sikecil = []
task_set_doc_siaga = []
task_set_doc_penggalang = []
task_set_doc_penegak = []

query_ref = taskset_coll_ref.order_by("id", direction=firestore.Query.DESCENDING)
for doc in query_ref.stream():
    record = doc.to_dict()

    if record["challenge_group"] == "sikecil":
        task_set_doc_sikecil.append({
            "doc_id": record["challenge_group"]+"_"+record["id"],
            "title": record["title"],
            "challenge_group": record["challenge_group"],
            "status": record["status"],
        })
    elif record["challenge_group"] == "siaga":
        task_set_doc_siaga.append({
            "doc_id": record["challenge_group"]+"_"+record["id"],
            "title": record["title"],
            "challenge_group": record["challenge_group"],
            "status": record["status"],
        })

    elif record["challenge_group"] == "penggalang":
        task_set_doc_penggalang.append({
            "doc_id": record["challenge_group"]+"_"+record["id"],
            "title": record["title"],
            "challenge_group": record["challenge_group"],
            "status": record["status"],
        })
    elif record["challenge_group"] == "penegak":
        task_set_doc_penegak.append({
            "doc_id": record["challenge_group"]+"_"+record["id"],
            "title": record["title"],
            "challenge_group": record["challenge_group"],
            "status": record["status"],
        })


configuration_coll_ref.document('global_variables').update({
    "task_set_doc_sikecil": task_set_doc_sikecil
})
configuration_coll_ref.document('global_variables').update({
    "task_set_doc_siaga": task_set_doc_siaga
})
configuration_coll_ref.document('global_variables').update({
    "task_set_doc_penggalang": task_set_doc_penggalang
})
configuration_coll_ref.document('global_variables').update({
    "task_set_doc_penegak": task_set_doc_penegak
})

print("sikecil : ", len(task_set_doc_sikecil))
print("siaga : ", len(task_set_doc_siaga))
print("penggalang : ", len(task_set_doc_penggalang))
print("penegak : ", len(task_set_doc_penegak))