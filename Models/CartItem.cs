using Google.Cloud.Firestore;

namespace EcommerceApp.Models
{
    [FirestoreData]
    public class CartItem
    {
        [FirestoreDocumentId]
        public string ProductId { get; set; }
        [FirestoreProperty]
        public int Quantity { get; set; }
    }
} 