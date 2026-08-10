from sentence_transformers import SentenceTransformer

model = SentenceTransformer("all-MiniLM-L6-v2")


def create_embeddings(documents):

    return model.encode(
        documents,
        convert_to_numpy=True
    )


def create_query_embedding(question):

    return model.encode(
        question,
        convert_to_numpy=True
    )