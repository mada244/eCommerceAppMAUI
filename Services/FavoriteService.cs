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

        public async Task AddToFavoritesAsync(string userId, string productId, string productName, double price, string imageUrl)
        {
            if (string.IsNullOrEmpty(userId))
            {
                System.Diagnostics.Debug.WriteLine("Cannot add to favorites: UserId is null or empty");
                return;
            }

            await LoadFavoritesAsync(userId);
            var existingFavorite = _favorites.FirstOrDefault(fav => fav.ProductId == productId);
            if (existingFavorite == null)
            {
                var newFavorite = new Favorite
                {
                    ProductId = productId,
                    ProductName = productName,
                    Price = price,
                    ImageUrl = imageUrl
                };
                _favorites.Add(newFavorite);
                await SaveFavoritesAsync();
            }
        }

        public async Task AddToFavoritesForCurrentUserAsync(string productId, string productName, double price, string imageUrl)
        {
            if (!_authService.IsAuthenticated)
            {
                System.Diagnostics.Debug.WriteLine("Cannot add to favorites: User is not authenticated");
                return;
            }

            await AddToFavoritesAsync(_authService.UserId, productId, productName, price, imageUrl);
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

        public async Task RemoveFromFavoritesForCurrentUserAsync(string productId)
        {
            if (!_authService.IsAuthenticated)
            {
                System.Diagnostics.Debug.WriteLine("Cannot remove from favorites: User is not authenticated");
                return;
            }

            await RemoveFromFavoritesAsync(_authService.UserId, productId);
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
                    // Șterge toate documentele existente
                    var snapshot = await favCollection.GetSnapshotAsync();
                    var deleteTasks = snapshot.Documents.Select(doc => doc.Reference.DeleteAsync());
                    await Task.WhenAll(deleteTasks);
                    // Adaugă toate favoritele actuale
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

       
        // Metode pentru compatibilitate cu codul existent

        public void AddToFavorites(string productId, string productName, double price, string imageUrl) => 
            Task.Run(() => AddToFavoritesForCurrentUserAsync(productId, productName, price, imageUrl));
        public void RemoveFromFavorites(string productId) => 
            Task.Run(() => RemoveFromFavoritesForCurrentUserAsync(productId));
    }
} 