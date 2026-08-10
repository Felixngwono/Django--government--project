from .embeddings import create_query_embedding
from .vector_store import search_vector_database


def retrieve_documents(question):

    embedding = create_query_embedding(question)

    results = search_vector_database(embedding)

    documents = results["documents"][0]

    return documents