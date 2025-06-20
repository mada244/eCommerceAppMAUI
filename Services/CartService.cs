using EcommerceApp.Models;
using System.Text.Json;
using System.IO;
using Microsoft.Maui.Storage;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace EcommerceApp.Services
{
    public class CartService
    {

        private List<CartItem> _cartItems = new();
        private string _userId = string.Empty;
        private FirebaseAuthService _authService;

        public CartService(FirebaseAuthService authService) {
            _authService = authService;        }

        public async Task LoadCartAsync(string userId)
        {
            if (string.IsNullOrEmpty(userId))
            {
                System.Diagnostics.Debug.WriteLine("Cannot load cart: UserId is null or empty");
                return;
            }

            _userId = userId;
            try
            {
                // Pentru moment, folosim doar local storage
                // TODO: Implement Firebase integration when needed
                //LoadCartLocal(userId);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading cart: {ex.Message}");
                // Fallback la local storage
                //LoadCartLocal(userId);
            }
        }

        public async Task LoadCartForCurrentUserAsync()
        {
            if (!_authService.IsAuthenticated)
            {
                System.Diagnostics.Debug.WriteLine("Cannot load cart: User is not authenticated");
                return;
            }

            await LoadCartAsync(_authService.UserId);
        }

        //private void LoadCartLocal(string userId)
        //{
        //    var file = GetFileName(userId);
        //    if (File.Exists(file))
        //    {
        //        var json = File.ReadAllText(file);
        //        List<CartItem>? list = JsonSerializer.Deserialize<List<CartItem>>(json);
        //        if (list != null)
        //            _cartItems = list;
        //    }
        //    else
        //    {
        //        _cartItems = new();
        //    }
        //}

        public List<CartItem> GetCartItems() => _cartItems;

        public async Task AddToCartAsync(string userId, string productId, string productName, double price, string imageUrl, int quantity = 1)
        {
            if (string.IsNullOrEmpty(userId))
            {
                System.Diagnostics.Debug.WriteLine("Cannot add to cart: UserId is null or empty");
                return;
            }

            await LoadCartAsync(userId);
            var existingItem = _cartItems.FirstOrDefault(item => item.ProductId == productId);
            if (existingItem != null)
            {
                existingItem.Quantity += quantity;
            }
            else
            {
                var newItem = new CartItem
                {
                    ProductId = productId,
                    ProductName = productName,
                    Price = price,
                    Quantity = quantity,
                    ImageUrl = imageUrl
                };
                _cartItems.Add(newItem);
            }
            await SaveCartAsync();
        }

        public async Task AddToCartForCurrentUserAsync(string productId, string productName, double price, string imageUrl, int quantity = 1)
        {
            if (!_authService.IsAuthenticated)
            {
                System.Diagnostics.Debug.WriteLine("Cannot add to cart: User is not authenticated");
                return;
            }

            await AddToCartAsync(_authService.UserId, productId, productName, price, imageUrl, quantity);
        }

        public async Task UpdateQuantityAsync(string userId, string itemId, int newQuantity)
        {
            if (string.IsNullOrEmpty(userId))
            {
                System.Diagnostics.Debug.WriteLine("Cannot update quantity: UserId is null or empty");
                return;
            }

            await LoadCartAsync(userId);
            var item = _cartItems.FirstOrDefault(item => item.Id == itemId);
            if (item != null)
            {
                if (newQuantity <= 0)
                {
                    await RemoveFromCartAsync(userId, itemId);
                }
                else
                {
                    item.Quantity = newQuantity;
                    await SaveCartAsync();
                }
            }
        }

        public async Task RemoveFromCartAsync(string userId, string itemId)
        {
            if (string.IsNullOrEmpty(userId))
            {
                System.Diagnostics.Debug.WriteLine("Cannot remove from cart: UserId is null or empty");
                return;
            }

            await LoadCartAsync(userId);
            var item = _cartItems.FirstOrDefault(item => item.Id == itemId);
            if (item != null)
            {
                _cartItems.Remove(item);
                await SaveCartAsync();
            }
        }

        public async Task ClearCartAsync(string userId)
        {
            if (string.IsNullOrEmpty(userId))
            {
                System.Diagnostics.Debug.WriteLine("Cannot clear cart: UserId is null or empty");
                return;
            }

            await LoadCartAsync(userId);
            _cartItems.Clear();
            await SaveCartAsync();
        }

        public double GetCartTotal()
        {
            return _cartItems.Sum(item => item.Price * item.Quantity);
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

        private async Task SaveCartAsync()
        {
            if (!string.IsNullOrEmpty(_userId))
            {
                try
                {
                    // Pentru moment, salvează doar local
                    // TODO: Implement Firebase integration when needed
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error saving cart: {ex.Message}");
                    // Fallback la local storage
                }
            }
        }

        // Metode pentru compatibilitate cu codul existent
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