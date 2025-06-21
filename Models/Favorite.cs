using Google.Cloud.Firestore;

namespace EcommerceApp.Models
{
    [FirestoreData]
    public class Favorite
    {
        [FirestoreProperty]
        public string ProductId { get; set; }
    }
} 