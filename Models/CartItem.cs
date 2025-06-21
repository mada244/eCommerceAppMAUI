using Google.Cloud.Firestore;

namespace EcommerceApp.Models
{
    [FirestoreData]
    public class CartItem
    {
        [FirestoreProperty]
        public string ProductId { get; set; }
        [FirestoreProperty]
        public int Quantity { get; set; }
    }
} 