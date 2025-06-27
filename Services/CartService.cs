using EcommerceApp.Models;
using System.Text.Json;
using System.IO;
using Microsoft.Maui.Storage;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Collections.ObjectModel;
using Google.Cloud.Firestore;

namespace EcommerceApp.Services
{
    public class CartService
    {
        private ObservableCollection<CartItem> _cartItems = new();
        private string _userId = string.Empty;
        private FirebaseAuthService _authService;

        public CartService(FirebaseAuthService authService) {
            _authService = authService;
        }

        public ObservableCollection<Product> CartProduct { get; set; } = new ObservableCollection<Product>();

        public async Task LoadCartAsync(string userId)
        {
            if (string.IsNullOrEmpty(userId))
            {
                System.Diagnostics.Debug.WriteLine("Cannot load cart: User is not authenticated");
                _cartItems.Clear();
                CartProduct.Clear();
                return;
            }

            _userId = userId;
            try
            {
                var db = FirebaseConfig.GetFirestoreDb();
                var cartCollection = db.Collection("users").Document(userId).Collection("cart");
                var productsCollection = db.Collection("Products");

                var cartSnapshot = await cartCollection.GetSnapshotAsync();
                
                _cartItems.Clear();
                CartProduct.Clear();

                foreach (var document in cartSnapshot.Documents)
                {
                    var cartItem = document.ConvertTo<CartItem>();
                    _cartItems.Add(cartItem);

                    var productDoc = await productsCollection.Document(cartItem.ProductId).GetSnapshotAsync();
                    if (productDoc.Exists)
                    {
                        var product = productDoc.ConvertTo<Product>();
                        CartProduct.Add(product);
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading cart: {ex.Message}");
            }
        }

        public async Task LoadCartForCurrentUserAsync()
        {
            if (!_authService.IsAuthenticated)
            {
                System.Diagnostics.Debug.WriteLine("Cannot load cart: User is not authenticated");
                _cartItems.Clear();
                CartProduct.Clear();
                return;
            }

            await LoadCartAsync(_authService.UserId);
        }

        public ObservableCollection<CartItem> GetCartItems() => _cartItems;

        public async Task AddToCartAsync(string userId, string productId, int quantity = 1)
        {
            try
            {
                if (string.IsNullOrEmpty(userId))
                {
                    System.Diagnostics.Debug.WriteLine("Cannot add to cart: UserId is null or empty");
                    return;
                }

                var db = FirebaseConfig.GetFirestoreDb();
                var user = db.Collection("users").Document(userId);
                var cartItemRef = user.Collection("cart").Document(productId);
                var doc = await cartItemRef.GetSnapshotAsync();

                    var newItem = new CartItem
                    {
                        ProductId = productId,
                        Quantity = doc.Exists ? doc.ConvertTo<CartItem>().Quantity + quantity : quantity,
                    };
                    await cartItemRef.SetAsync(newItem);
                
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                throw;
            }
        }

        public async Task AddToCartForCurrentUserAsync(string productId, string productName, double price, string imageUrl, int quantity = 1)
        {
            if (!_authService.IsAuthenticated)
            {
                System.Diagnostics.Debug.WriteLine("Cannot add to cart: User is not authenticated");
                return;
            }

            await AddToCartAsync(_authService.UserId, productId, quantity);
        }

        public async Task UpdateQuantityAsync(string userId, string itemId, int newQuantity)
        {
            if (string.IsNullOrEmpty(userId))
            {
                System.Diagnostics.Debug.WriteLine("Cannot update quantity");
                return;
            }
            if (newQuantity <= 0)
            {
                await RemoveFromCartAsync(userId, itemId);
            }
            else
            {
                var db = FirebaseConfig.GetFirestoreDb();
                var cartItemRef = db.Collection("users").Document(userId).Collection("cart").Document(itemId);
                await cartItemRef.UpdateAsync("Quantity", newQuantity);
            }
        }

        public async Task RemoveFromCartAsync(string userId, string itemId)
        {
            if (string.IsNullOrEmpty(userId))
            {
                System.Diagnostics.Debug.WriteLine("Cannot remove from cart");
                return;
            }
            var db = FirebaseConfig.GetFirestoreDb();
            var cartItemRef = db.Collection("users").Document(userId).Collection("cart").Document(itemId);
            await cartItemRef.DeleteAsync();
        }

        public async Task ClearCartAsync(string userId)
        {
            if (string.IsNullOrEmpty(userId))
            {
                System.Diagnostics.Debug.WriteLine("Cannot clear cart");
                return;
            }

            var db = FirebaseConfig.GetFirestoreDb();
            var cartCollection = db.Collection("users").Document(userId).Collection("cart");
            var snapshot = await cartCollection.GetSnapshotAsync();
            
            var batch = db.StartBatch();
            foreach (var doc in snapshot.Documents)
            {
                batch.Delete(doc.Reference);
            }
            await batch.CommitAsync();
        }

        public double GetCartTotal()
        {
            return 0;
        }

        public int GetCartItemCount()
        {
            return _cartItems.Sum(item => item.Quantity);
        }

        public bool IsUserAuthenticated()
        {
            return _authService.IsAuthenticated;
        }

        public string GetCurrentUserId()
        {
            return _authService.UserId;
        }

        public void AddToCart(string productId, string productName, double price, string imageUrl) => 
            Task.Run(() => AddToCartForCurrentUserAsync(productId, productName, price, imageUrl));
        public void UpdateQuantity(string itemId, int newQuantity) => 
            Task.Run(() => UpdateQuantityAsync(_authService.UserId, itemId, newQuantity));
        public void RemoveFromCart(string itemId) => 
            Task.Run(() => RemoveFromCartAsync(_authService.UserId, itemId));
        public void ClearCart() => 
            Task.Run(() => ClearCartAsync(_authService.UserId));
    }
} 