"""Generate Testing Quiz

This script allows us to add a new (testing) quiz & specify the participant.
We can also add more participants in the existing quiz by filling the value of `quiz_doc_id`.
"""

import json
import os
from datetime import datetime
from firebase_admin import credentials, initialize_app, firestore


QUIZ_TEMPLATE = {
    "title": None,
    "created_at": str(datetime.now()),
    "start_at": "2024-01-01 00:00:00",
    "end_at": "2045-12-31 00:00:00",
    "tasks": {'penegak': [], 'penggalang': [], 'siaga': [], 'sikecil': []},
    "max_attempts": {'penegak': 1, 'penggalang': 1, 'siaga': 1, 'sikecil': 1},
    "duration_minute": {'penegak': 24, 'penggalang': 24, 'siaga': 20, 'sikecil': 15},
    "sponsors": {'penegak': None, 'penggalang': None, 'siaga': None, 'sikecil': None},
}

PARTICIPANT_TEMPLATE = {
    "created_at": str(datetime.now()),
    "user_uid": "",
    "user_name": "",
    "challenge_group": "penegak",
    "quiz_id": None,
    "quiz_title": None,
    "quiz_start_at": None,
    "quiz_end_at": None,
    "quiz_max_attempts": 1,
    "attempts": []
}


creds = credentials.Certificate(
    json.loads(os.environ["FIREBASE_SECRET_KEY_JSON"])
)
initialize_app(creds)
firestore_client = firestore.client()


def add_new_testing_quiz_data(quiz_title, quiz_tasks):
    quiz_data = QUIZ_TEMPLATE
    quiz_data["title"] = quiz_title
    quiz_data["tasks"]["penegak"] = quiz_tasks

    col_ref = firestore_client.collection("weekly_quiz_list")
    _, doc_ref = col_ref.add(quiz_data)
    quiz_data["doc_id"] = doc_ref.id

    return quiz_data


def register_participant(participants, quiz_data):
    col_ref = firestore_client.collection("weekly_quiz_participation")
    participant_data = PARTICIPANT_TEMPLATE
    participant_data["quiz_title"] = quiz_data["title"]
    participant_data["quiz_id"] = quiz_data["doc_id"]
    participant_data["quiz_start_at"] = quiz_data["start_at"]
    participant_data["quiz_end_at"] = quiz_data["end_at"]
    print("Registered participant IDs: ")

    for user_name, user_uid in participants:
        participant_data["user_name"] = user_name
        participant_data["user_uid"] = user_uid
        _, doc_ref = col_ref.add(participant_data)
        print(doc_ref.id)


if __name__ == "__main__":
    quiz_doc_id = None
    quiz_title = "Testing Latihan Bebras @now"               # edit this
    quiz_tasks = ["2016-BE-01", "2016-LT-02", "2016-JP-01"]  # edit this

    # list of participant in the format (user_name, user_uid)
    participants = [
        ("User 1", "YHyEryTmogRIIaUNMHcOD72ZsaV"),           # delete this
        ("User 2", "YeGQ3YBWXkRbDMfRu4z5cjrdeqV"),           # delete this
    ]

    # # ToDo: add functionality to also remove unused testing quiz 
    # prev_quiz_id = []

    if quiz_doc_id is None:
        quiz = add_new_testing_quiz_data(quiz_title, quiz_tasks)
        print("Generated Quiz {}, ID: {}".format(quiz["title"], quiz["doc_id"]))
    else:
        col_ref = firestore_client.collection("weekly_quiz_list")
        doc = col_ref.document(quiz_doc_id).get()
        if doc.exists:
            quiz = doc.to_dict()
            quiz["doc_id"] = doc.id
            print("Registered more participants in Quiz {}, ID: {}".format(quiz["title"], quiz["doc_id"]))
        else:
            raise Exception("Quiz not found!")
    
    register_participant(participants, quiz)
