using Google.Cloud.Firestore;
using Microsoft.Maui.Storage;

public class FirebaseConfig
{
    private static FirestoreDb? _firestoreDb;

    public static async Task<FirestoreDb> InitializeFirestoreAsync()
    {
        try
        {
            using var stream = await FileSystem.OpenAppPackageFileAsync("service-account-key.json");
            var localPath = Path.Combine(FileSystem.CacheDirectory, "service-account-key.json");
            using (var fileStream = File.OpenWrite(localPath))
            {
                await stream.CopyToAsync(fileStream);
            }

            Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", localPath);

            _firestoreDb = FirestoreDb.Create("ecommerce-e5dfd");
            return _firestoreDb;
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"Firebase initialization error: {ex.Message}");
            throw;
        }
    }

    public static FirestoreDb GetFirestoreDb()
    {
        if (_firestoreDb == null)
        {
            throw new InvalidOperationException("Firebase not initialized. Call InitializeFirestoreAsync() first.");
        }
        return _firestoreDb;
    }

    public static void InitializeFirestore()
    {
        _ = InitializeFirestoreAsync();
    }
}

