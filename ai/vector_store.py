import chromadb

from .document_loader import load_project_documents
from .embeddings import create_embeddings


client = chromadb.PersistentClient(path="./chroma_db")


def build_vector_database():

    documents = load_project_documents()

    embeddings = create_embeddings(documents)

    try:
        client.delete_collection("government_projects")
    except Exception:
        pass

    collection = client.create_collection(
        name="government_projects"
    )

    ids = [str(i) for i in range(len(documents))]

    collection.add(
        ids=ids,
        documents=documents,
        embeddings=embeddings.tolist()
    )

    return len(documents)


def search_vector_database(query_embedding, top_k=5):

    collection = client.get_collection(
        "government_projects"
    )

    results = collection.query(
        query_embeddings=[query_embedding.tolist()],
        n_results=top_k
    )

    return results