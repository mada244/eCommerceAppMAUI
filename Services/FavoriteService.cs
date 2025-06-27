using EcommerceApp.Models;
using System.Text.Json;
using System.IO;
using Microsoft.Maui.Storage;
using System.Collections.Generic;
using System.Threading.Tasks;
using Google.Cloud.Firestore;
using System.Collections.ObjectModel;

namespace EcommerceApp.Services
{
    public class FavoriteService
    {
        private List<Favorite> _favorites = new();
        private string _userId = string.Empty;
        private FirebaseAuthService _authService;

        public FavoriteService(FirebaseAuthService authService) {
            _authService = authService;
        }

        public ObservableCollection<Product> FavoriteProducts { get; set; } = new ObservableCollection<Product>();

        public async Task LoadFavoritesAsync(string userId)
        {
            if (string.IsNullOrEmpty(userId))
            {
                System.Diagnostics.Debug.WriteLine("Cannot load favorites: User is not authenticated");
                return;
            }

            _userId = userId;
            try
            {
                var db = FirebaseConfig.GetFirestoreDb();
                var favCollection = db.Collection("users").Document(userId).Collection("favorites");
                var productsCollection = db.Collection("Products");

                var favSnapshot = await favCollection.GetSnapshotAsync();
                FavoriteProducts.Clear();
                foreach (var document in favSnapshot.Documents)
                {
                    var productId = document.Id;
                    var productDoc = await productsCollection.Document(productId).GetSnapshotAsync();

                    if (productDoc.Exists)
                    {
                        var product = productDoc.ConvertTo<Product>();
                        FavoriteProducts.Add(product);
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading favorites: {ex.Message}");
            }
        }

        public List<Favorite> GetFavorites() => _favorites;

        public async Task AddToFavoritesAsync(string userId, string productId)
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
                var cartItemRef = user.Collection("favorites").Document(productId);
                var doc = await cartItemRef.GetSnapshotAsync();

                var newItem = new CartItem
                {
                    ProductId = productId,
                };
                await cartItemRef.SetAsync(newItem);

            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                throw;
            }
        }

        public async Task RemoveFromFavoritesAsync(string userId, string productId)
        {
            if (string.IsNullOrEmpty(userId))
            {
                System.Diagnostics.Debug.WriteLine("Cannot remove from favorites: User is not authenticated");
                return;
            }

            await LoadFavoritesAsync(userId);
            var favorite = _favorites.FirstOrDefault(fav => fav.ProductId == productId);
            if (favorite != null)
            {
                _favorites.Remove(favorite);
                await SaveFavoritesAsync();
            }
        }

        public bool IsFavorite(string productId)
        {
            return _favorites.Any(fav => fav.ProductId == productId);
        }

        public bool IsUserAuthenticated()
        {
            return _authService.IsAuthenticated;
        }

        public string GetCurrentUserId()
        {
            return _authService.UserId;
        }

        private async Task SaveFavoritesAsync()
        {
            if (!string.IsNullOrEmpty(_userId))
            {
                try
                {
                    var db = FirebaseConfig.GetFirestoreDb();
                    var favCollection = db.Collection("users").Document(_userId).Collection("favorites");
                    var snapshot = await favCollection.GetSnapshotAsync();
                    var deleteTasks = snapshot.Documents.Select(doc => doc.Reference.DeleteAsync());
                    await Task.WhenAll(deleteTasks);
                    var addTasks = _favorites.Select(item =>
                        favCollection.Document(item.ProductId).SetAsync(item));
                    await Task.WhenAll(addTasks);
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"Error saving favorites: {ex.Message}");
                }
            }
        }

        public void AddToFavorites(string productId) => 
            Task.Run(() => AddToFavoritesAsync(_authService.UserId ,productId));
        public void RemoveFromFavorites(string productId) => 
            Task.Run(() => RemoveFromFavoritesAsync(_authService.UserId,productId));
    }
} 