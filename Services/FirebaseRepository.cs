
using Google.Cloud.Firestore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FirebaseApi
{
    public class FirebaseRepository<T> where T : class
    {
        private readonly CollectionReference _collection;

        public FirebaseRepository(string collectionName, FirestoreDb firestoreDb)
        {
            _collection = firestoreDb.Collection(collectionName);
        }

        public async Task<IEnumerable<T>> GetAllAsync()
        {
            var snapshot = await _collection.GetSnapshotAsync();
            return snapshot.Documents.Select(doc => doc.ConvertTo<T>());
        }

        public async Task<T> GetByIdAsync(string id)
        {
            var docRef = _collection.Document(id);
            var snapshot = await docRef.GetSnapshotAsync();

            if (!snapshot.Exists)
            {
                return null;
            }

            return snapshot.ConvertTo<T>();
        }

        public async Task CreateAsync(string id, T entity)
        {
            var docRef = _collection.Document(id);
            await docRef.SetAsync(entity);
        }

        public async Task UpdateAsync(string id, T entity)
        {
            var docRef = _collection.Document(id);
            await docRef.SetAsync(entity, SetOptions.Overwrite);
        }

        public async Task<bool> DeleteAsync(string id)
        {
            var docRef = _collection.Document(id);
            var snapshot = await docRef.GetSnapshotAsync();

            if (!snapshot.Exists)
            {
                return false;
            }

            await docRef.DeleteAsync();
            return true;
        }

        public async Task<bool> ExistsAsync(string id)
        {
            var docRef = _collection.Document(id);
            var snapshot = await docRef.GetSnapshotAsync();
            return snapshot.Exists;
        }
    }
}
