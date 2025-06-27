using Google.Cloud.Firestore;
using System.Collections.Generic;

namespace EcommerceApp.Models
{
    [FirestoreData]
    public class Product
    {
        [FirestoreDocumentId]
        public string Id { get; set; }
        [FirestoreProperty]
        public string Name { get; set; }
        [FirestoreProperty]
        public string Description { get; set; }
        [FirestoreProperty]
        public double Price { get; set; }
        [FirestoreProperty]
        public string ImageUrl { get; set; }
        [FirestoreProperty]
        public string Brand { get; set; }
        [FirestoreProperty]
        public string Category { get; set; }
        [FirestoreProperty]
        public List<string> Colors { get; set; } = new();
        [FirestoreProperty]
        public List<string> Sizes { get; set; } = new();
        [FirestoreProperty]
        public List<string> ImageUrls { get; set; } = new(); 
        [FirestoreProperty]
        public List<string> Variants { get; set; } = new(); 
    }
} 