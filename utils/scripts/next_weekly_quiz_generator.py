import json
import os
import random
from datetime import datetime, timedelta
from firebase_admin import credentials, initialize_app, firestore


creds = credentials.Certificate(
    json.loads(os.environ["FIREBASE_SECRET_KEY_JSON"])
)
initialize_app(creds)

firestore_client = firestore.client()
configuration_coll_ref = firestore_client.collection("configuration")
problemset_coll_ref = firestore_client.collection("problem_set")
weeklyquizlist_coll_ref = firestore_client.collection("weekly_quiz_list")

config_global_variables = configuration_coll_ref.document("global_variables").get().to_dict()
config_global_variables["weeklyquiz_number"] += 1  # increase weekly quiz number ID
today = datetime.now()
monday = (
    today - timedelta(days=today.weekday())
).replace(
    hour=0,
    minute=0,
    second=0,
    microsecond=0
)
result = {
    "title": f"LATIHAN BEBRAS MINGGUAN #{config_global_variables['weeklyquiz_number']}",
    "created_at": str(today),
    "start_at": str(monday + timedelta(days=7)),
    "end_at": str(monday + timedelta(days=14)),
    "problems": {},
    "max_attempts": {},
    "duration_minute": {},
    "sponsors": {}
}

challengegroup_map = configuration_coll_ref.document("challenge_group").get().to_dict()
for cg_group, cg_val in challengegroup_map.items():
    problem_id_list = []

    query_ref = problemset_coll_ref.where("challenge_group", "==", cg_group)
    for doc in query_ref.stream():
        problem_id_list.append(doc.to_dict()["id"])
    random.shuffle(problem_id_list)

    result["problems"][cg_group] = problem_id_list[:cg_val["weeklyquiz_problem_number"]]
    result["max_attempts"][cg_group] = cg_val["weeklyquiz_max_attempts"]
    result["duration_minute"][cg_group] = cg_val["weeklyquiz_duration_minute"]

    # ToDo: later, make a logic to fill the sponsor(s)
    result["sponsors"][cg_group] = None

# for history data
_, doc_ref = weeklyquizlist_coll_ref.add(result)
result["id"] = doc_ref.id  # generate random id & put it in the `result` for latest data

# for latest data
to_running = configuration_coll_ref.document("next_weekly_quiz").get().to_dict()
configuration_coll_ref.document("next_weekly_quiz").set(result)
configuration_coll_ref.document("running_weekly_quiz").set(to_running)

# update global variables
configuration_coll_ref.document("global_variables").set(config_global_variables)
